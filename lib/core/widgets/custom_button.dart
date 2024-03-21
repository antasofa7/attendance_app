import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Get.theme.primaryColor),
              foregroundColor:
                  MaterialStatePropertyAll(Get.theme.colorScheme.onPrimary),
              fixedSize: const MaterialStatePropertyAll(
                  Size.fromWidth(double.infinity))),
          child: Text(label)),
    );
  }
}
