import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Database/models/task_model.dart';
import '../../../Logic/controllers/crud_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_images.dart';
import '../../../Utils/app_strings.dart';
import '../../../Utils/snackbar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_textField_widget.dart';
import 'Widgets/delete_task_dialog.dart';
import 'Widgets/update_task_date_time.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({Key? key}) : super(key: key);

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crudController.taskModel = Get.arguments;
    crudController.selectedEditColorIndex.value = crudController.colors
        .indexWhere(
            (color) => color.value == crudController.taskModel.getColor().value);
    crudController.titleEditController.value.text =
        crudController.taskModel.title ?? "";
    crudController.descriptionEditController.value.text =
        crudController.taskModel.description ?? "";
    crudController.dateEditController.value.text =
        crudController.taskModel.date ?? "";
    crudController.timeEditController.value.text =
        crudController.taskModel.time ?? "";
  }

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
                      "UPDATE TASK",
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
                          final isSelected = index ==
                              crudController.selectedEditColorIndex.value;
                          return IconButton(
                            onPressed: () {
                              crudController.selectedEditColor.value = item;
                              crudController.selectedEditColorIndex.value =
                                  index;
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
                  controller: crudController.titleEditController.value,
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
                  controller: crudController.descriptionEditController.value,
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
                  controller: crudController.dateEditController.value,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    UpdateTaskDateAndTime().pickDate(context);
                  },
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
                  controller: crudController.timeEditController.value,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    UpdateTaskDateAndTime().pickTime(context);
                  },
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
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      title: "Update Task",
                      backgroundColor: AppColors.MAIN_COLOR,
                      borderSideColor: AppColors.MAIN_COLOR,
                      foregroundColor: AppColors.WHITE_COLOR,
                      overlayColor: AppColors.WHITE_COLOR,
                      onPress: () {
                        crudController
                            .updateTaskInDatabase(TaskModel(
                              id: crudController.taskModel.id,
                              title:
                                  crudController.titleEditController.value.text,
                              description: crudController
                                  .descriptionEditController.value.text,
                              color: crudController.selectedEditColor.value,
                              date:
                                  crudController.dateEditController.value.text,
                              status: "status",
                              time:
                                  crudController.timeEditController.value.text,
                            ))
                            .whenComplete(
                              () => showSnackbar(
                                  title: AppStrings.STATUS,
                                  message: AppStrings.TASK_UPDATED,
                                  backgroundColor: AppColors.MAIN_COLOR,
                                  icon: Icons.verified_user_rounded),
                            );
                      },
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CustomButton(
                      title: "Delete Task",
                      backgroundColor: AppColors.RED_COLOR,
                      borderSideColor: AppColors.RED_COLOR,
                      foregroundColor: AppColors.WHITE_COLOR,
                      overlayColor: AppColors.WHITE_COLOR,
                      onPress: () {
                        showDeleteConfirmationDialog(
                          () {
                            crudController.deleteTask(crudController.taskModel.id!);
                          },
                          context,
                        );
                      },
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
