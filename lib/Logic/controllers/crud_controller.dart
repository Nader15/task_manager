import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Utils/app_colors.dart';
import '../../Database/Database_Helper/new_database_helper.dart';
import '../../Database/models/task_model.dart';
import '../../Database/task_table.dart';
import '../../Models/login_model.dart';
import '../../Routes/routes.dart';
import '../../Services/auth_services.dart';
import '../../Utils/app_strings.dart';
import '../../Utils/snackbar.dart';

class CrudController extends GetxController {
  late TaskTable taskTable;
  late TaskModel taskModel;

  @override
  void onInit() async {
    super.onInit();
   await loadTasks();
    createNotification();
  }

  @override
  void onClose() {
    super.onClose();
  }

  List<MaterialColor> colors = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.indigo,
    Colors.green,
    Colors.yellow,
  ];

  var isTasksLoading = false.obs;
  var tasks = <TaskModel>[].obs;

  Future loadTasks() async {
    isTasksLoading(true);
    final dbHelper = TaskDatabaseHelper();
    tasks.value = await dbHelper.getTasks();
    log(tasks.length.toString());
    log("Hi");
    log(tasks.map((element) => element.date).toList().toString());
    isTasksLoading(false);
    // Do something with the retrieved tasks
  }

  Future<void> fetchTasksByDate(DateTime selectedDate) async {
    isTasksLoading(true);
    tasks.value = await TaskDatabaseHelper().getTasksByDate(selectedDate);
    isTasksLoading(false);
  }

  Future saveTasks(List<TaskModel> tasks) async {
    final dbHelper = TaskDatabaseHelper();
    for (var task in tasks) {
      await dbHelper.insertTask(task);
    }
    titleController.value.clear();
    descriptionController.value.clear();
    dateController.value.clear();
    timeController.value.clear();
    onInit();
    Get.back();
  }


  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var dateController = TextEditingController().obs;
  var timeController = TextEditingController().obs;
  var selectedColor = Colors.green.obs;
  RxInt selectedColorIndex = RxInt(-1);

  var titleEditController = TextEditingController().obs;
  var descriptionEditController = TextEditingController().obs;
  var dateEditController = TextEditingController().obs;
  var timeEditController = TextEditingController().obs;
  Rx<Color> selectedEditColor = Colors.red.obs;
  RxInt selectedEditColorIndex = RxInt(-1);

  Future updateTaskInDatabase(TaskModel updatedTask) async {
    final dbHelper = TaskDatabaseHelper();
    await dbHelper.updateTask(updatedTask);
    loadTasks();
    Get.back();
  }

  Future<void> deleteTask(int id) async {
    final dbHelper = TaskDatabaseHelper();
    await dbHelper.deleteTask(id);
    tasks.removeWhere((task) => task.id == id);
    Get.offAllNamed(Routes.homeScreen);
    showSnackbar(
        title: AppStrings.STATUS,
        message: AppStrings.TASK_DELETED,
        backgroundColor: AppColors.MAIN_COLOR,
        icon: Icons.verified_user_rounded
    );
  }

  bool isControllerEmpty() {
    if (titleController.value.text.isEmpty ||
        descriptionController.value.text.isEmpty ||
        dateController.value.text.isEmpty ||
        timeController.value.text.isEmpty){
      return true;
    }else{
      return false;
    }
  }
  Future createNotification()async{
    for(int i=0;i< tasks.length;i++){
      if(DateTime.parse(tasks[i].time!).isAfter(DateTime.now())){
        log("item.time --> ${DateTime.parse(tasks[i].time!)}");
        log("item.date --> ${DateTime.parse(tasks[i].date!)}");
        log("DateTime.now --> ${DateTime.now()}");
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: i,
                channelKey: 'key1',
                title: 'Task Alert',
                body: tasks[i].title,
                bigPicture: 'https://protocoderspoint.com/wp-content/uploads/2021/05/Monitize-flutter-app-with-google-admob-min-741x486.png',
                notificationLayout: NotificationLayout.BigPicture
            ),
            schedule: NotificationCalendar(
              year: DateTime.parse(tasks[i].time!).year,
              month: DateTime.parse(tasks[i].time!).month,
              day: DateTime.parse(tasks[i].time!).day,
              hour: DateTime.parse(tasks[i].time!).hour,
              minute: DateTime.parse(tasks[i].time!).minute,
              second: DateTime.parse(tasks[i].time!).second,
              millisecond: 0,
              allowWhileIdle: true,
            )
        );
      }
    }
  }
}
