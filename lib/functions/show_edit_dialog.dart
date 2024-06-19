import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lelos_orders_app/functions/copy_files_to_app_path.dart';
import 'package:lelos_orders_app/functions/show_add_dialog.dart';
import 'package:lelos_orders_app/models/order_model.dart';
import 'package:lelos_orders_app/providers/images_provider.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';
import 'package:lelos_orders_app/widgets/galary_view.dart';

void displayEditTodoDialog(BuildContext context, Order order) {
  TextEditingController orderController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  orderController.text = order.order;
  descriptionController.text = order.description;
  DateTime selectedDate = order.date;
  List<String> images = order.images;
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Consumer(builder: (context, ref, child) {
        final imagePicker = ref.watch(imagePickerProvider(images));
        return SingleChildScrollView(
          child: AlertDialog(
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
                Consumer(builder: (context, ref, child) {
                  return SizedBox(
                    height: (imagePicker.length <= 9) ? null : 200,
                    child: GalleryView(
                      images: imagePicker,
                    ),
                  );
                }),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    await ref
                        .read(imagePickerProvider(images).notifier)
                        .pickImages();
                  },
                  child: const Text('Pick Images'),
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
                  onPressed: () async {
                    final newPaths = await copyFilesToAppPath(imagePicker);
                    await deleteUnusedFiles([order]);
                    Order newOrder = order.copyWith(
                      order: orderController.text,
                      description: descriptionController.text,
                      date: selectedDate,
                      images: newPaths,
                    );
                    ref.read(orderProvider.notifier).editOrder(newOrder);
                    ref
                        .read(imagePickerProvider(imagePicker).notifier)
                        .clearState();
                    Navigator.of(context).pop();
                  },
                );
              }),
            ],
          ),
        );
      });
    },
  );
}
