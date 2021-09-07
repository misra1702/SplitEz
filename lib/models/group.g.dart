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
      ..grpContacts = (fields[1] as List).cast<Contacts>()
      ..expense = (fields[2] as List).cast<Expenses>();
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

class ContactsAdapter extends TypeAdapter<Contacts> {
  @override
  final int typeId = 1;

  @override
  Contacts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contacts(
      name: fields[0] as String,
    )..phoneNum = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Contacts obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpensesAdapter extends TypeAdapter<Expenses> {
  @override
  final int typeId = 2;

  @override
  Expenses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expenses(
      title: fields[0] as String,
    )
      ..whoPaid = (fields[1] as List).cast<double>()
      ..whoBought = (fields[2] as List).cast<double>();
  }

  @override
  void write(BinaryWriter writer, Expenses obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.whoPaid)
      ..writeByte(2)
      ..write(obj.whoBought);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpensesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
