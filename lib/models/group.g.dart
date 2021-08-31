// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupAdapter extends TypeAdapter<Group> {
  @override
  final int typeId = 0;

  @override
  Group read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Group(
      grpName: fields[0] as String,
    )
      ..grpContacts = (fields[1] as List).cast<Contact>()
      ..expense = (fields[2] as List)
          .map((dynamic e) => (e as List)
              .map((dynamic e) => (e as Map).cast<String, double>())
              .toList())
          .toList();
  }

  @override
  void write(BinaryWriter writer, Group obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.grpName)
      ..writeByte(1)
      ..write(obj.grpContacts)
      ..writeByte(2)
      ..write(obj.expense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
