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

  @HiveField(5, defaultValue: [])
  List<String> images;

  Order({
    required this.order,
    this.isCompleted = false,
    required this.date,
    required this.uuid,
    this.description = '',
    this.images = const [],
  });

  

  Order copyWith({
    String? order,
    bool? isCompleted,
    DateTime? date,
    int? uuid,
    String? description,
    List<String>? images,
  }) {
    return Order(
      order: order ?? this.order,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      uuid: uuid ?? this.uuid,
      description: description ?? this.description,
      images: images ?? this.images,
    );
  }
}
