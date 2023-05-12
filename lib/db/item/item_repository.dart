import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

import 'item.dart';
import 'item_dao.dart';
import 'item_dao_impl.dart';

class ItemRepository {
  late ItemDao itemDao;

  late final StreamController itemStreamController;
  late final Stream itemStream;
  late final StreamSubscription<RealmResultsChanges<Item>> itemsSubscription;

  ItemRepository(this.itemDao) {
    init();
  }

  init() {
    itemStreamController = StreamController<RealmResults<Item>>();
    itemStream = itemStreamController.stream;

    itemsSubscription = itemDao.getItems().changes.listen(
      (changes) {
        // changes.result why? changes result will give RealmResults
        itemStreamController.add(changes.results);
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
}

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository(ref.watch(itemDaoProvider));
});
