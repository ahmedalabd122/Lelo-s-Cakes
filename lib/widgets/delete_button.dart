import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lelos_orders_app/providers/order_provider.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.onPressed,
    this.title,
  });
  final void Function() onPressed;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed.call,
      icon: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffEA7260),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: .5,
            color: const Color(0xff31233D),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            title != null ? Text('  $title') : Container(),
            const AspectRatio(
              aspectRatio: 1,
              child: Icon(
                Icons.delete_outline,
                color: Color(0xff33002C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
