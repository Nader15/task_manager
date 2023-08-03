import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Logic/controllers/crud_controller.dart';
import '../../../../Utils/app_colors.dart';


class DatePicker extends StatelessWidget {
   DatePicker({Key? key}) : super(key: key);

   final crudController = Get.find<CrudController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DatePickerWidget(
        looping: false, // default is not looping
        firstDate: DateTime(2000, 1, 1),
        // lastDate: DateTime.now(),
        initialDate: DateTime.now(),
        dateFormat: "dd/MMMM/yyyy",
          // 2023-08-03 00:00:00.000
          // 2023-08-04 00:00:00.000
        onChange: (DateTime selectedDate, _) {
          log("into filter date -->${selectedDate}");
            crudController.fetchTasksByDate(selectedDate);
        },
        pickerTheme: const DateTimePickerTheme(

          backgroundColor: Colors.transparent,
          itemTextStyle: TextStyle(color: AppColors.MAIN_COLOR, fontSize: 15),
          dividerColor: AppColors.MAIN_COLOR,
        ),
      ),
    );
  }
}
