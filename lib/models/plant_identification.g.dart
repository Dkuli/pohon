// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_identification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantIdentificationAdapter extends TypeAdapter<PlantIdentification> {
  @override
  final int typeId = 0;

  @override
  PlantIdentification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlantIdentification(
      species: fields[0] as String,
      family: fields[1] as String,
      commonNames: (fields[2] as List).cast<String>(),
      probability: fields[3] as double,
      gbifId: fields[4] as String,
      identificationDate: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PlantIdentification obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.species)
      ..writeByte(1)
      ..write(obj.family)
      ..writeByte(2)
      ..write(obj.commonNames)
      ..writeByte(3)
      ..write(obj.probability)
      ..writeByte(4)
      ..write(obj.gbifId)
      ..writeByte(5)
      ..write(obj.identificationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantIdentificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
