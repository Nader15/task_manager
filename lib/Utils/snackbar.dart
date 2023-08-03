import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Utils/app_colors.dart';

Future<void> showSnackbar({
  required String title,
  required String message,
  Color? backgroundColor = AppColors.MAIN_COLOR,
  IconData? icon,
}) async {
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
