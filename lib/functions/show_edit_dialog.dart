import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lelos_orders_app/functions/show_add_dialog.dart';
import 'package:lelos_orders_app/order_model.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';

void displayEditTodoDialog(BuildContext context, Order order) {
  TextEditingController orderController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  orderController.text = order.order;
  descriptionController.text = order.description;
  DateTime selectedDate = order.date;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer(builder: (context, ref, child) {
        return AlertDialog(
          backgroundColor: const Color(0xff61C0BF),
          title: const Text('Edit Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: orderController,
                decoration: const InputDecoration(hintText: 'Order'),
              ),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                minLines: 1,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              const SizedBox(height: 10),
              LelosDatePicker(
                newSelectedDate: selectedDate,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Consumer(builder: (context, ref, child) {
              return TextButton(
                child: const Text('Edit'),
                onPressed: () {
                  order.order = orderController.text;
                  order.description = descriptionController.text;
                  order.date = ref.watch(dateProvider);
                  ref.read(orderProvider.notifier).editOrder(order);
                  Navigator.of(context).pop();
                },
              );
            }),
          ],
        );
      });
    },
  );
}
