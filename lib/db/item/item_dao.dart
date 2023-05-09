import 'package:realm/realm.dart';

import 'item.dart';

abstract class ItemDao {
  openRealm();

  closeRealm();

  RealmResults<Item> getItems();

  bool addItem(String text);

  bool deleteItem(Item item);
}
