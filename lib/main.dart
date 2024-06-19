
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lelos_orders_app/pages/orders_page.dart';
import 'package:lelos_orders_app/models/order_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(
    OrderAdapter(),
  );
  await Hive.openBox<Order>('orders');
  runApp(const ProviderScope(
    child: LelosOrdersApp(),
  ));
}

class LelosOrdersApp extends StatelessWidget {
  const LelosOrdersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lelo' 's Orders App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xffFF8DD3),
        fontFamily: 'BalooBhaijaan2',
      ),
      home: const OrdersList(),
    );
  }
}
