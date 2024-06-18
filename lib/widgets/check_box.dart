import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    super.key,
    required this.onPressed,
    this.title,
    required this.isChecked,
  });
  final void Function() onPressed;
  final String? title;
  final bool isChecked;

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox>
    with TickerProviderStateMixin {
  bool animate = false;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.onPressed();
        animate = !animate;
        animationController.forward(from: 0.0);
      },
      icon: AspectRatio(
        aspectRatio: 1,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xff7FBC95),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: .5,
              color: const Color(0xff31233D),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                50,
              ),
              border: Border.all(
                width: 1,
                color: const Color(0xff31233D),
              ),
            ),
            child: widget.isChecked == true
                ? const Center(
                    child: Icon(
                      Icons.check,
                      color: Color(0xff33002C),
                      size: 16,
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    )
        .animate(
          controller: animationController,
        )
        .scale(
          duration: const Duration(milliseconds: 300),
          begin: const Offset(.8, .8),
          curve: Curves.easeOut,
          end: const Offset(1, 1),
        );
  }
}
