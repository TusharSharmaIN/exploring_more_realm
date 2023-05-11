// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Item extends _Item with RealmEntity, RealmObjectBase, RealmObject {
  Item(
    String text,
    bool isMarked,
    int quantity,
  ) {
    RealmObjectBase.set(this, 'text', text);
    RealmObjectBase.set(this, 'isMarked', isMarked);
    RealmObjectBase.set(this, 'quantity', quantity);
  }

  Item._();

  @override
  String get text => RealmObjectBase.get<String>(this, 'text') as String;
  @override
  set text(String value) => RealmObjectBase.set(this, 'text', value);

  @override
  bool get isMarked => RealmObjectBase.get<bool>(this, 'isMarked') as bool;
  @override
  set isMarked(bool value) => RealmObjectBase.set(this, 'isMarked', value);

  @override
  int get quantity => RealmObjectBase.get<int>(this, 'quantity') as int;
  @override
  set quantity(int value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  Stream<RealmObjectChanges<Item>> get changes =>
      RealmObjectBase.getChanges<Item>(this);

  @override
  Item freeze() => RealmObjectBase.freezeObject<Item>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Item._);
    return const SchemaObject(ObjectType.realmObject, Item, 'Item', [
      SchemaProperty('text', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('isMarked', RealmPropertyType.bool),
      SchemaProperty('quantity', RealmPropertyType.int),
    ]);
  }
}
