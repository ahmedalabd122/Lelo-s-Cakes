import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class LocalPathModel {
  @HiveField(0)
  String path;
  LocalPathModel({
    required this.path,
  });
}
