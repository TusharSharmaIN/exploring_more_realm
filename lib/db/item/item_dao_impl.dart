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
        _realm.add<Item>(Item(text));
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
}
