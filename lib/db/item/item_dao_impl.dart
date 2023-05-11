import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import 'item.dart';
import 'item_dao.dart';

class ItemDaoImpl implements ItemDao {
  final Configuration _config = Configuration.local([Item.schema]);
  late Realm _realm;

  ItemDaoImpl() {
    openRealm();
  }

  @override
  openRealm() {
    _realm = Realm(_config);
  }

  @override
  closeRealm() {
    if (!_realm.isClosed) {
      _realm.close();
    }
  }

  @override
  RealmResults<Item> getItems() {
    return _realm.all<Item>();
  }

  @override
  bool addItem(String text) {
    try {
      _realm.write(() {
        _realm.add<Item>(Item(text, false, 1));
      });
      return true;
    } on RealmException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  bool deleteItem(Item item) {
    try {
      _realm.write(() {
        _realm.delete(item);
      });
      return true;
    } on RealmException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  bool toggleFavourite(Item item) {
    try {
      _realm.write(() {
        item.isMarked = !item.isMarked;
        debugPrint("Toggled to ${item.isMarked}");
      });
      return true;
    } on RealmException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  bool updateQuantity(Item item, int offset) {
    try {
      _realm.write(() {
        item.quantity = item.quantity + offset;
        debugPrint("Quantity added to ${item.quantity}");
      });
      return true;
    } on RealmException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  bool clearItems() {
    try {
      _realm.write(() {
        _realm.deleteAll<Item>();
      });
      return true;
    } on RealmException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }
}
