import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/View/Screens/CRUD_SCREENS/Widgets/add_task_date_time.dart';

import '../../../Database/models/task_model.dart';
import '../../../Logic/controllers/auth_controller.dart';
import '../../../Logic/controllers/crud_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_images.dart';
import '../../../Utils/app_strings.dart';
import '../../../Utils/snackbar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_textField_widget.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  final crudController = Get.find<CrudController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: AppConstants.mediaHeight(context),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.background_image),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      // splashRadius: 25,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: AppColors.MAIN_COLOR,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.WHITE_COLOR,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "NEW TASK",
                      style:
                          TextStyle(color: AppColors.MAIN_COLOR, fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: crudController.colors.asMap().entries.map(
                        (entry) {
                          final index = entry.key;
                          final item = entry.value;
                          final isSelected =
                              index == crudController.selectedColorIndex.value;
                          return IconButton(
                            onPressed: () {
                              crudController.selectedColor.value = item;
                              crudController.selectedColorIndex.value = index;
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    if (isSelected)
                                      BoxShadow(
                                          color: AppColors.GREY_COLOR,
                                          blurRadius: 10,
                                          spreadRadius: 3)
                                  ]),
                              child: CircleAvatar(
                                backgroundColor: isSelected
                                    ? AppColors.WHITE_COLOR
                                    : Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(1),
                                  child: Icon(
                                    Icons.circle,
                                    color: item,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    )),
                TextFormField(
                  controller: crudController.titleController.value,
                  decoration: InputDecoration(
                      label: Text("Title"),
                      labelStyle: TextStyle(color: AppColors.GREY_COLOR),
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.GREY_COLOR),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                      )),
                ),
                SizedBox(height: 20),
                Text(
                  "Description",
                  style: TextStyle(color: AppColors.GREY_COLOR),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: crudController.descriptionController.value,
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: AppColors.WHITE_COLOR,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.GREY_COLOR),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    AddTaskDateAndTime().pickDate(context);
                  },
                  controller: TextEditingController(
                    text: crudController.dateController.value.text.isEmpty
                        ? ""
                        : DateFormat('dd MMMM yyyy').format(
                            DateTime.parse(
                                crudController.dateController.value.text),
                          ),
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.date_range),
                    label: Text("Date"),
                    labelStyle: TextStyle(color: AppColors.GREY_COLOR),
                    contentPadding: EdgeInsets.zero,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.GREY_COLOR),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: TextEditingController(
                    text: crudController.timeController.value.text.isEmpty
                        ? ""
                        : DateFormat('h:mm a').format(
                      DateTime.parse(crudController.timeController.value.text),
                    ),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    AddTaskDateAndTime().pickTime(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.access_time_outlined),
                    label: Text("Time"),
                    labelStyle: TextStyle(color: AppColors.GREY_COLOR),
                    contentPadding: EdgeInsets.zero,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.GREY_COLOR),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                CustomButton(
                  title: "Add Task",
                  backgroundColor: AppColors.MAIN_COLOR,
                  borderSideColor: AppColors.MAIN_COLOR,
                  foregroundColor: AppColors.WHITE_COLOR,
                  overlayColor: AppColors.WHITE_COLOR,
                  onPress: () {
                    if (crudController.isControllerEmpty()) {
                      showSnackbar(
                        title: AppStrings.STATUS,
                        message: AppStrings.EMPTY_FIELDS,
                        backgroundColor: AppColors.RED_COLOR,
                        icon: Icons.warning,
                      );
                    } else {
                      crudController.saveTasks([
                        TaskModel(
                          title: crudController.titleController.value.text,
                          description:
                              crudController.descriptionController.value.text,
                          color: crudController.selectedColor.value,
                          date: crudController.dateController.value.text,
                          status: "status",
                          time: crudController.timeController.value.text,
                        )
                      ]).whenComplete(
                        () => showSnackbar(
                            title: AppStrings.STATUS,
                            message: AppStrings.TASK_ADDED,
                            backgroundColor: AppColors.MAIN_COLOR,
                            icon: Icons.verified_user_rounded),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
