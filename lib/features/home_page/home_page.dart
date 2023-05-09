import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../../db/item/item.dart';
import '../../db/item/item_dao.dart';
import '../../db/item/item_dao_impl.dart';
import 'add_item_view.dart';
import 'item_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ItemDao itemDao;
  late RealmResults<Item> items;

  @override
  void initState() {
    super.initState();
    itemDao = ItemDaoImpl();
    loadItems();
  }

  void loadItems() {
    setState(() {
      items = itemDao.getItems();
    });
  }

  onAdd(String text) {
    debugPrint('Adding $text');
    if (itemDao.addItem(text)) {
      debugPrint('Added $text');
      loadItems();
    } else {
      debugPrint('Something went wrong while adding $text');
    }
  }

  onDelete(Item item) {
    debugPrint('Deleting ${item.text}');
    if (itemDao.deleteItem(item)) {
      loadItems();
    } else {
      debugPrint('Something went wrong while deleting ${item.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Column(children: [
        AddItemView(
          onAdd: onAdd,
        ),
        Expanded(
          child: ItemListView(
            items: items.toList(),
            onDelete: onDelete,
          ),
        )
      ]),
    );
  }
}
