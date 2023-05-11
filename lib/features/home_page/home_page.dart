import 'dart:async';

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

  late final StreamController itemStreamController;
  late final Stream itemStream;
  late final StreamSubscription<RealmResultsChanges<Item>> itemsSubscription;

  @override
  void initState() {
    super.initState();
    itemDao = ItemDaoImpl();

    itemStreamController = StreamController<RealmResultsChanges<Item>>();
    itemStream = itemStreamController.stream;

    items = itemDao.getItems();
    itemsSubscription = items.changes.listen(
      (changes) {
        // print("=====================");
        // print("inserted: ${changes.inserted}");
        // print("deleted: ${changes.deleted}");
        // print("newModified: ${changes.newModified}");
        // print("results: ${changes.results}");
        // print("isCleared: ${changes.isCleared}");
        // print("=====================");
        itemStreamController.add(changes);
      },
    );
  }

  onAdd(String text) {
    debugPrint('Adding $text');
    if (itemDao.addItem(text)) {
      debugPrint('Added $text');
    } else {
      debugPrint('Something went wrong while adding $text');
    }
  }

  onDelete(Item item) {
    debugPrint('Deleting ${item.text}');
    if (itemDao.deleteItem(item)) {
    } else {
      debugPrint('Something went wrong while deleting ${item.text}');
    }
  }

  onFavourite(Item item) {
    debugPrint('Setting favourite for ${item.text}');
    if (itemDao.toggleFavourite(item)) {
    } else {
      debugPrint(
          'Something went wrong while setting favourite for ${item.text}');
    }
  }

  onIncrementQuantity(Item item) {
    debugPrint('Increment quantity for ${item.text}');
    if (itemDao.updateQuantity(item, 1)) {
    } else {
      debugPrint(
          'Something went wrong while incrementing quantity for ${item.text}');
    }
  }

  onDecrementQuantity(Item item) {
    debugPrint('Decrement quantity for ${item.text}');
    if (item.quantity > 1) {
      if (itemDao.updateQuantity(item, -1)) {
      } else {
        debugPrint(
            'Something went wrong while decrementing quantity for ${item.text}');
      }
    } else {
      onDelete(item);
    }
  }

  onClear() {
    debugPrint('Clearing List Items');
    if (itemDao.clearItems()) {
    } else {
      debugPrint('Something went wrong while clearing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          AddItemView(
            onAdd: onAdd,
            onClear: onClear,
          ),
          const Divider(
            thickness: 2,
          ),
          Expanded(
            child: StreamBuilder(
              stream: itemStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
                return ItemListView(
                  items: items.toList(),
                  onDelete: onDelete,
                  onFavourite: onFavourite,
                  onIncrementQuantity: onIncrementQuantity,
                  onDecrementQuantity: onDecrementQuantity,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
