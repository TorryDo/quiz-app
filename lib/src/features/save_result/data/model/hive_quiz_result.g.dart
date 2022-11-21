// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_quiz_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveQuizResultAdapter extends TypeAdapter<HiveQuizResult> {
  @override
  final int typeId = 0;

  @override
  HiveQuizResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveQuizResult()
      ..validNumber = fields[0] as int
      ..quizId = fields[1] as int
      ..submittedTime = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, HiveQuizResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.validNumber)
      ..writeByte(1)
      ..write(obj.quizId)
      ..writeByte(2)
      ..write(obj.submittedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveQuizResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
