import 'package:exploring_more_realm/utils/app_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../db/item/item.dart';
import '../../utils/app_styles/app_colors.dart';

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
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: getItemBuilder,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
    );
  }

  Widget getItemBuilder(BuildContext context, int index) {
    Item item = items[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          children: [
            //  tap able button to mark/un-mark
            _getTapButton(item.isMarked, item),
            Expanded(
              child: Text(
                item.text,
                style: AppTextStyles.poppinsNormal18.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
            //  delete button
            IconButton(
              onPressed: () => onDelete(item),
              icon: Icon(
                Icons.delete,
                color: AppColors.greyLight,
                size: 25,
                semanticLabel: 'Delete ${item.text}',
              ),
            )
          ],
        ),
      ),
    );

    // return Row(
    //   children: [
    //     Expanded(
    //       child: Text(
    //         item.text,
    //         style: Theme.of(context).textTheme.bodyLarge,
    //       ),
    //     ),
    //     IconButton(
    //       onPressed: () => onDecrementQuantity(item),
    //       icon: const Icon(
    //         Icons.remove,
    //         color: Colors.indigo,
    //         size: 25,
    //         semanticLabel: 'Remove',
    //       ),
    //     ),
    //     Text(
    //       "${item.quantity}",
    //       style: const TextStyle(
    //         fontWeight: FontWeight.bold,
    //         fontSize: 18,
    //       ),
    //     ),
    //     IconButton(
    //       onPressed: () => onIncrementQuantity(item),
    //       icon: const Icon(
    //         Icons.add,
    //         color: Colors.indigo,
    //         size: 25,
    //         semanticLabel: 'Add More',
    //       ),
    //     ),
    //     IconButton(
    //       onPressed: () => onFavourite(item),
    //       icon: Icon(
    //         Icons.check,
    //         color: item.isMarked ? Colors.teal : Colors.black12,
    //         size: 25,
    //         semanticLabel: 'Mark Favorite',
    //       ),
    //     ),
    //     IconButton(
    //       onPressed: () => onDelete(item),
    //       icon: Icon(
    //         Icons.delete,
    //         color: Colors.indigo,
    //         size: 25,
    //         semanticLabel: 'Delete ${item.text}',
    //       ),
    //     )
    //   ],
    // );
  }

  Widget _getTapButton(bool isMarked, Item item) {
    return isMarked
        ? IconButton(
            onPressed: () => onFavourite(item),
            icon: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.yellow,
              size: 25,
            ),
          )
        : IconButton(
            onPressed: () => onFavourite(item),
            icon: const Icon(
              Icons.circle_outlined,
              color: AppColors.white,
              size: 25,
            ),
          );
  }
}
