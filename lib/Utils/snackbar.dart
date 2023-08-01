import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showSnackbar(
  String title,
  String message,
  Color? backgroundColor,
  IconData? icon,
) async {
  Get.snackbar(
    title,
    message,
    icon: Icon(icon, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: backgroundColor,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    colorText: Colors.white,
    duration: const Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
