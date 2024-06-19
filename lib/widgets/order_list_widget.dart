import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lelos_orders_app/functions/show_add_dialog.dart';
import 'package:lelos_orders_app/functions/show_alert_dialog.dart';
import 'package:lelos_orders_app/functions/show_edit_dialog.dart';
import 'package:lelos_orders_app/models/order_model.dart';
import 'package:lelos_orders_app/pages/order_details_page.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';
import 'package:lelos_orders_app/widgets/check_box.dart';
import 'package:lelos_orders_app/widgets/delete_button.dart';
import 'package:intl/intl.dart';

class OrdersListView extends ConsumerWidget {
  const OrdersListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderProvider);
    final dates = ref.read(orderProvider.notifier).getAllBookedDates();
    return ListView.builder(
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final String dateString =
            '${dates[index].day} - ${dates[index].month} - ${dates[index].year}';
        final String day = DateFormat('EEEE').format(dates[index]);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateString,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  day,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(dateProvider.notifier).state = dates[index];
                    displayAddTodoDialog(context, selectedDate: dates[index]);
                  },
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            OrdersByDateListView(date: dates[index]),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}

class OrdersByDateListView extends ConsumerWidget {
  const OrdersByDateListView({
    super.key,
    required this.date,
  });
  final DateTime date;

  @override
  Widget build(BuildContext context, ref) {
    final ordersByDate = ref.read(orderProvider.notifier).getOrdersByDate(date);
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: ordersByDate.length,
      itemBuilder: (context, index) {
        final order = ordersByDate[index];
        final animationIndex =
            index + (10 * ref.read(orderProvider.notifier).getDateIndex(date));
        return AnimatedListTile(
          order: order,
          animationIndex: animationIndex,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}

class AnimatedListTile extends StatefulWidget {
  const AnimatedListTile({
    super.key,
    required this.order,
    required this.animationIndex,
  });
  final Order order;
  final int animationIndex;
  @override
  State<AnimatedListTile> createState() => _AnimatedListTileState();
}

class _AnimatedListTileState extends State<AnimatedListTile> {
  bool startAnimate = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          color: const Color(0xff9B61EE),
          borderRadius: BorderRadius.circular(10),
          border: Border.all()),
      width: MediaQuery.of(context).size.width,
      duration: Duration(
        milliseconds: 300 + (widget.animationIndex * 30),
      ),
      curve: Curves.fastEaseInToSlowEaseOut,
      transform: Matrix4.translationValues(
          startAnimate ? 0 : MediaQuery.of(context).size.width, 0, 0),
      child: Consumer(
        builder: (context, ref, child) => ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OrderDetailsPage(
                  order: widget.order,
                ),
              ),
            );
          },
          onLongPress: () {
            ref.read(dateProvider.notifier).state = widget.order.date;
            displayEditTodoDialog(context, widget.order);
          },
          selectedColor: Colors.red,
          title: Text(
            widget.order.order,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            widget.order.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomCheckBox(
                isChecked: widget.order.isCompleted,
                onPressed: () {
                  ref
                      .read(orderProvider.notifier)
                      .toggleCompletionStatus(widget.order.uuid);
                  log(widget.order.uuid.toString());
                },
              ),
              DeleteButton(
                onPressed: () {
                  displayAlertDialog(
                    context,
                    title:
                        "Are you sure to delete this order? \n ${widget.order.order}",
                    onYes: () {
                      ref
                          .read(orderProvider.notifier)
                          .removeOrder(widget.order.uuid);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
