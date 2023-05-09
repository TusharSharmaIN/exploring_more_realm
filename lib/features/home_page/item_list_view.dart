import 'package:flutter/material.dart';
import '../../db/item/item.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({
    Key? key,
    required this.items,
    required this.onDelete,
  }) : super(key: key);

  final List<Item> items;

  final Function(Item) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemBuilder: getItemBuilder,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: getSeparatorBuilder,
      itemCount: items.length,
    );
  }

  Widget getItemBuilder(BuildContext context, int index) {
    Item item = items[index];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item.text,
        ),
        IconButton(
          onPressed: () => onDelete(item),
          icon: Icon(
            Icons.delete,
            color: Colors.indigo,
            size: 25,
            semanticLabel: 'Delete ${item.text}',
          ),
        )
      ],
    );
  }

  Widget getSeparatorBuilder(BuildContext context, int index) {
    return const Divider(
      thickness: 1,
      color: Colors.indigo,
    );
  }
}
