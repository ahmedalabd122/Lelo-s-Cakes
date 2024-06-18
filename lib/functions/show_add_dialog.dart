import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';

void displayAddTodoDialog(BuildContext context, {DateTime? selectedDate}) {
  TextEditingController orderController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime newSelectedDate = selectedDate ?? DateTime.now();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer(builder: (context, ref, child) {
        final date = ref.watch(dateProvider);
        return AlertDialog(
          backgroundColor: const Color(0xff61C0BF),
          title: const Text('Add a new Order'),
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
                newSelectedDate: date,
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
                child: const Text('Add'),
                onPressed: () {
                  ref.read(orderProvider.notifier).addOrder(
                        orderController.text,
                        descriptionController.text,
                        ref.watch(dateProvider),
                      );
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

class LelosDatePicker extends ConsumerWidget {
  LelosDatePicker({super.key, required this.newSelectedDate});
  DateTime newSelectedDate;

  @override
  Widget build(BuildContext context, ref) {
    final date = ref.watch(dateProvider);
    return Column(
      children: [
        Text(ref.watch(dateProvider).toLocal().toString().split(' ')[0]),
        ElevatedButton(
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
          child: const Text("Select due date"),
        ),
      ],
    );
  }
}
