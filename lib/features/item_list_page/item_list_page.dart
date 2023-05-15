import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/item/item_repository.dart';
import '../../db/item/item_dao.dart';
import '../../utils/app_styles/app_text_styles.dart';
import '../../utils/app_styles/app_colors.dart';
import 'add_item_view.dart';
import 'item_list_view.dart';

class ItemListPage extends ConsumerWidget {
  const ItemListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  using this to perform operations data repository
    final itemOperations = ref.read(itemRepositoryProvider);
    //  using this to listen to stream from repository
    final itemStream = ref.watch(itemRepositoryProvider).itemStream;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shopping list (${snapshot.data.length})",
                      style: AppTextStyles.poppinsNormal24,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 36,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: <Widget>[
                          getFilterButtons(
                            () {
                              itemOperations.updateMarkedFilterType(
                                MarkedFilterType.all,
                              );
                            },
                            "All",
                          ),
                          const SizedBox(width: 12),
                          getFilterButtons(
                            () {
                              itemOperations.updateMarkedFilterType(
                                MarkedFilterType.completed,
                              );
                            },
                            "Completed",
                          ),
                          const SizedBox(width: 12),
                          getFilterButtons(
                            () {
                              itemOperations.updateMarkedFilterType(
                                MarkedFilterType.uncompleted,
                              );
                            },
                            "Uncompleted",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ItemListView(
                        items: snapshot.data.toList(),
                        onDelete: itemOperations.onDelete,
                        onFavourite: itemOperations.onFavourite,
                        onIncrementQuantity: itemOperations.onIncrementQuantity,
                        onDecrementQuantity: itemOperations.onDecrementQuantity,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          AddItemView(
            onAdd: itemOperations.onAdd,
            onClear: itemOperations.onClear,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget getFilterButtons(void Function() onTap, String text) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.greyLight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Text(text),
        ),
      ),
    );
  }
}
