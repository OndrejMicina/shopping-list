// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroceryListAdapter extends TypeAdapter<GroceryList> {
  @override
  final int typeId = 1;

  @override
  GroceryList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroceryList(
      fields[0] as String,
      fields[1] as String,
      (fields[2] as List).cast<Grocery>(),
    );
  }

  @override
  void write(BinaryWriter writer, GroceryList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.groceries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroceryListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
