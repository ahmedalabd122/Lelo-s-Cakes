import 'package:hive/hive.dart';

part 'order_model.g.dart';

@HiveType(typeId: 0)
class Order {
  @HiveField(0)
  String order;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  DateTime date;

  @HiveField(3, defaultValue: -1)
  int uuid;

  @HiveField(4, defaultValue: '')
  String description = '';

  @HiveField(5, defaultValue: '')
  String image;

  Order({
    required this.order,
    this.isCompleted = false,
    required this.date,
    required this.uuid,
    this.description = '',
    this.image = '',
  });
}
