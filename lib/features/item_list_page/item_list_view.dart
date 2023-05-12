import 'package:flutter/material.dart';
import '../../db/item/item.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({
    Key? key,
    required this.items,
    required this.onDelete,
    required this.onFavourite,
    required this.onIncrementQuantity,
    required this.onDecrementQuantity,
  }) : super(key: key);

  final List<Item> items;

  final Function(Item) onDelete;
  final Function(Item) onFavourite;
  final Function(Item) onIncrementQuantity;
  final Function(Item) onDecrementQuantity;

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
      children: [
        Expanded(
          child: Text(
            item.text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        IconButton(
          onPressed: () => onDecrementQuantity(item),
          icon: const Icon(
            Icons.remove,
            color: Colors.indigo,
            size: 25,
            semanticLabel: 'Remove',
          ),
        ),
        Text(
          "${item.quantity}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        IconButton(
          onPressed: () => onIncrementQuantity(item),
          icon: const Icon(
            Icons.add,
            color: Colors.indigo,
            size: 25,
            semanticLabel: 'Add More',
          ),
        ),
        IconButton(
          onPressed: () => onFavourite(item),
          icon: Icon(
            Icons.check,
            color: item.isMarked ? Colors.teal : Colors.black12,
            size: 25,
            semanticLabel: 'Mark Favorite',
          ),
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
