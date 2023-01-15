import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class project {
  @HiveField(0)
  String title;
  @HiveField(1)
  String owner;
  @HiveField(2)
  String description;
  @HiveField(3)
  int members;

  project(this.title, this.owner, this.description, this.members);

  String key() => title.hashCode.toString();
}

class projectAdapter extends TypeAdapter<project> {
  @override
  final int typeId = 0;

  @override
  project read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return project(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, project obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.owner)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.members);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is projectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
