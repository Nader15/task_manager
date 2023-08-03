import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/View/Widgets/custom_circle_progress.dart';

import '../../../Database/models/task_model.dart';
import '../../../Database/task_table.dart';
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
import 'Widgets/date_picker_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

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
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Logout",style: TextStyle(color: AppColors.RED_COLOR),),
                                  content: Text("Are you sure you want to Logout?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed:(){
                                        GetStorage().remove("AccessToken");
                                        Get.offAllNamed(Routes.loginScreen);
                                        showSnackbar(
                                            title: AppStrings.LOG_OUT,
                                            message: AppStrings.LOGGED_OUT,
                                            backgroundColor: AppColors.MAIN_COLOR,
                                            icon: Icons.verified_user_rounded);
                                      },
                                      child: Text("Logout",style: TextStyle(color: AppColors.RED_COLOR),),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.logout,
                            color: AppColors.RED_COLOR,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         InkWell(
                           onTap: (){
                             crudController.loadTasks();
                           },
                           child: Row(
                             children: [
                               Text(
                                 "TODO",
                                 style: TextStyle(
                                     color: AppColors.MAIN_COLOR, fontSize: 30),
                               ),
                               Icon(Icons.refresh)
                             ],
                           ),
                         ),
                          IconButton(
                            // splashRadius: 25,
                            onPressed: () {
                              Get.toNamed(Routes.addTaskScreen);
                            },
                            icon: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: AppColors.MAIN_COLOR,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.add,
                                color: AppColors.WHITE_COLOR,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          crudController.fetchTasksByDate(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())));
                          },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Today",
                                  style: TextStyle(
                                      color: AppColors.BLACK_COLOR, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${DateFormat('EEEE').format(DateTime.now())}",
                                  style: TextStyle(
                                      color: AppColors.MAIN_COLOR, fontSize: 12),
                                ),
                              ],
                            ),
                            Text(
                              "${DateFormat('dd MMMM yyyy').format(DateTime.now())}",
                              style: TextStyle(
                                  color: AppColors.MAIN_COLOR, fontSize: 12),
                            ),
                          ],
                        ),
                      ),

                      DatePicker(),
                    ],
                  ),
                ),
              ),
              Obx(
                () {
                  if (crudController.isTasksLoading.value) {
                    return CustomCircleProgress();
                  }
                  if (crudController.tasks.isEmpty) {
                    return Center(
                      child: Text("There are no tasks"),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(
                          top: AppConstants.mediaHeight(context) / 2.3),
                      decoration: BoxDecoration(
                          color: AppColors.WHITE_COLOR,
                          borderRadius: BorderRadius.only(
                            topRight:
                                Radius.circular(AppConstants.widgetsCurve),
                            topLeft: Radius.circular(AppConstants.widgetsCurve),
                          )),
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          itemCount: crudController.tasks.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key(
                                  crudController.tasks[index].id.toString()),
                              background: Container(
                                color: Colors.red,
                                // Swipe background color when deleting
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              onDismissed: (direction) {
                                // Handle the dismiss action here, delete the task from the database
                                crudController.deleteTask(
                                    crudController.tasks[index].id!);

                                crudController.tasks.removeAt(index);
                              },
                              child: Card(
                                elevation: 10,
                                child: ListTile(
                                  onTap: () {
                                    Get.toNamed(Routes.updateTaskScreen,
                                        arguments: crudController.tasks[index]);
                                  },
                                  leading: Icon(
                                    Icons.circle,
                                    color:
                                        crudController.tasks[index].getColor(),
                                  ),
                                  title:
                                      Text(crudController.tasks[index].title!),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        DateFormat('dd MMMM yyyy').format(
                                          DateTime.parse(crudController.tasks[index].date!),
                                        ),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        DateFormat('h:mm a').format(
                                          DateTime.parse(crudController.tasks[index].time!),
                                        ),
                                        style: TextStyle(
                                            color: AppColors.GREY_COLOR),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 20,
                              )),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
