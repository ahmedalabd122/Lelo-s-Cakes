import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lelos_orders_app/providers/order_provider.dart';

void displayAlertDialog(
  BuildContext context, {
  required String title,
  required VoidCallback onYes,
}) {
  showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xff61C0BF),
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xff7FBC95),
            ),
            child: const Text(
              'No',
              style: TextStyle(color: Color(0xff31233D)),
            ),
          ),
          TextButton(
            onPressed: onYes,
            style:
                TextButton.styleFrom(backgroundColor: const Color(0xffEA7260)),
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Color(0xff31233D),
              ),
            ),
          ),
        ],
      );
    },
  );
}
