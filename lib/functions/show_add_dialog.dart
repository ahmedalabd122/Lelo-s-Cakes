import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lelos_orders_app/functions/copy_files_to_app_path.dart';
import 'package:lelos_orders_app/providers/images_provider.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';
import 'package:lelos_orders_app/widgets/galary_view.dart';

void displayAddTodoDialog(BuildContext context, {DateTime? selectedDate}) {
  TextEditingController orderController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> images = [];
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Consumer(builder: (context, ref, child) {
        final date = ref.watch(dateProvider);
        final imagePicker = ref.watch(imagePickerProvider(images));
        return AlertDialog(
          backgroundColor: const Color(0xff61C0BF),
          title: const Text('Add a new Order'),
          content: SingleChildScrollView(
            child: Column(
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
                  newSelectedDate: date,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                ref.read(imagePickerProvider(images).notifier).clearState();
                Navigator.of(context).pop();
              },
            ),
            Consumer(builder: (context, ref, child) {
              return TextButton(
                child: const Text('Add'),
                onPressed: () async {
                  final newPaths = await copyFilesToAppPath(imagePicker);
                  ref.read(orderProvider.notifier).addOrder(
                        order: orderController.text,
                        description: descriptionController.text,
                        date: ref.watch(dateProvider),
                        images: newPaths,
                      );
                  ref.read(imagePickerProvider(images).notifier).clearState();
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

// ignore: must_be_immutable
class LelosDatePicker extends ConsumerWidget {
  LelosDatePicker({super.key, required this.newSelectedDate});
  DateTime newSelectedDate;

  @override
  Widget build(BuildContext context, ref) {
    final date = ref.watch(dateProvider);
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: newSelectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (picked != null && picked != newSelectedDate) {
              newSelectedDate = picked;
              ref.read(dateProvider.notifier).state = picked;
            }
          },
          child: Text(date.toLocal().toString().split(' ')[0]),
        ),
      ],
    );
  }
}
