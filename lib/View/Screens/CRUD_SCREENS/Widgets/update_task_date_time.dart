import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../Utils/app_colors.dart';
import '../../../../Logic/controllers/crud_controller.dart';

class UpdateTaskDateAndTime {
  DateTime selectedDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();

  pickDate(BuildContext context) async {
    final crudController = Get.find<CrudController>();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: AppColors.MAIN_COLOR)),
            child: child!,
          );
        });
    crudController.dateEditController.value.clear();
    crudController.timeEditController.value.clear();
    if (picked != null) {
      // crudController.dateController.value.text = DateFormat('dd MMMM yyyy').format(picked);
      crudController.dateEditController.value.text = picked.toString();
      selectedDate = picked;
      // selectedDate = DateTime.now();

    } else {
      selectedDate = DateTime.now();
    }
  }

  pickTime(BuildContext context) async {
    final crudController = Get.find<CrudController>();
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: Theme(
              data: Theme.of(context).copyWith(
                  colorScheme:
                  ColorScheme.light(primary: AppColors.MAIN_COLOR)),
              child: child!,
            ),
          );
        });
    crudController.timeEditController.value.clear();
    if (pickedTime != null) {
      final selectedDateTime = DateTime(
        DateTime
            .parse(crudController.dateEditController.value.text)
            .year,
        DateTime
            .parse(crudController.dateEditController.value.text)
            .month,
        DateTime
            .parse(crudController.dateEditController.value.text)
            .day,
        pickedTime.hour,
        pickedTime.minute,
      );
      crudController.timeEditController.value.text =
          selectedDateTime.toString();
      initialTime = pickedTime;
      // }
    } else {
      initialTime = TimeOfDay.now();
    }
  }

}