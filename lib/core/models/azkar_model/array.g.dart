// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'array.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArrayAdapter extends TypeAdapter<Array> {
  @override
  final int typeId = 1;

  @override
  Array read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Array(
      id: fields[0] as int?,
      text: fields[1] as String?,
      count: fields[2] as int?,
      audio: fields[3] as String?,
      filename: fields[4] as String?,
      isFavorite: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Array obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.audio)
      ..writeByte(4)
      ..write(obj.filename)
      ..writeByte(5)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArrayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
