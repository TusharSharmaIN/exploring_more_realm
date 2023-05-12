import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../db/item/item_repository.dart';
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

    return Column(
      children: [
        AddItemView(
          onAdd: itemOperations.onAdd,
          onClear: itemOperations.onClear,
        ),
        StreamBuilder(
          stream: itemStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            return ItemListView(
              items: snapshot.data.toList(),
              onDelete: itemOperations.onDelete,
              onFavourite: itemOperations.onFavourite,
              onIncrementQuantity: itemOperations.onIncrementQuantity,
              onDecrementQuantity: itemOperations.onDecrementQuantity,
            );
          },
        )
      ],
    );
  }
}
