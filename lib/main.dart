import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lelos_orders_app/functions/show_add_dialog.dart';
import 'package:lelos_orders_app/functions/show_alert_dialog.dart';
import 'package:lelos_orders_app/pages/orders_page.dart';
import 'package:lelos_orders_app/widgets/delete_button.dart';
import 'package:lelos_orders_app/widgets/order_list_widget.dart';
import 'package:lelos_orders_app/order_model.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';

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
