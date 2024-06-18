import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lelos_orders_app/functions/show_add_dialog.dart';
import 'package:lelos_orders_app/functions/show_alert_dialog.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';
import 'package:lelos_orders_app/widgets/delete_button.dart';
import 'package:lelos_orders_app/widgets/order_list_widget.dart';

class OrdersList extends ConsumerWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context, ref) {
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
            DeleteButton(
              title: 'Delete All ',
              onPressed: () {
                displayAlertDialog(context,
                    title: 'Are you sure to delete all orders?', onYes: () {
                  ref.read(orderProvider.notifier).deleteAll();
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: OrdersListView(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff7FBC95),
          onPressed: () {
            ref.read(dateProvider.notifier).state = DateTime.now();
            displayAddTodoDialog(context);
          },
          tooltip: 'Add Order',
          child: const Icon(
            Icons.add,
            color: Color(0xff31233D),
          ),
        ),
      ),
    );
  }
}
