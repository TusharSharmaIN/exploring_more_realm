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
    final itemRepository = ref.read(itemRepositoryProvider);
    //  using this to listen to stream from repository
    final itemStream = ref.watch(itemRepositoryProvider).itemStream;

    return Column(
      children: [
        AddItemView(
          onAdd: itemRepository.onAdd,
          onClear: itemRepository.onClear,
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
              onDelete: itemRepository.onDelete,
              onFavourite: itemRepository.onFavourite,
              onIncrementQuantity: itemRepository.onIncrementQuantity,
              onDecrementQuantity: itemRepository.onDecrementQuantity,
            );
          },
        )
      ],
    );
  }
}
