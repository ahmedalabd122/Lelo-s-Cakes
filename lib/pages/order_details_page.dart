import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lelos_orders_app/functions/show_edit_dialog.dart';

import 'package:lelos_orders_app/models/order_model.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';
import 'package:lelos_orders_app/widgets/galary_view.dart';

class OrderDetailsPage extends ConsumerWidget {
  final Order order;

  const OrderDetailsPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, ref) {
    final thisOrder =
        ref.watch(orderProvider.notifier).getOrderById(order.uuid);
    log(thisOrder.images.length.toString());
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff61C0BF),
        appBar: AppBar(
          elevation: 2,
          shadowColor: const Color.fromARGB(255, 95, 16, 65),
          backgroundColor: const Color(0xffFF8DD3),
          leadingWidth: 100,
          leading: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Image(
              image: AssetImage('assets/appbar_icon.png'),
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(dateProvider.notifier).state = thisOrder.date;
                displayEditTodoDialog(context, thisOrder);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  thisOrder.order,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  thisOrder.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  DateFormat('EEEE').format(thisOrder.date),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${thisOrder.date.day} - ${thisOrder.date.month} - ${thisOrder.date.year}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GalleryView(
                  images: thisOrder.images,
                  isPicker: false,
                  order: order,
                  crossAxisCount: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
