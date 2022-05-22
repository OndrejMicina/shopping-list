// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroceryAdapter extends TypeAdapter<Grocery> {
  @override
  final int typeId = 2;

  @override
  Grocery read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grocery(
      fields[0] as String,
      fields[1] as double,
      fields[2] as String,
      fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Grocery obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.groceryName)
      ..writeByte(1)
      ..write(obj.ammount)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroceryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
