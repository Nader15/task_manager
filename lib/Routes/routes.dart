import 'package:get/get.dart';
import '../Logic/binding/auth_binding.dart';
import '../Logic/binding/crud_binding.dart';
import '../View/Screens/CRUD_SCREENS/add_task_screen.dart';
import '../View/Screens/CRUD_SCREENS/update_task_screen.dart';
import '../View/Screens/Home_Screen/home_screen.dart';
import '../View/Screens/Splash_Screen/splash_screen.dart';
import '../View/Screens/Login_Screen/login_screen.dart';

class AppRoutes {
  //initialRoute
  static const splashScreen = Routes.splashScreen;

  //getPages
  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      binding: CrudBinding(),
    ),
    GetPage(
      name: Routes.addTaskScreen,
      page: () => AddTaskScreen(),
      binding: CrudBinding(),
    ),
    GetPage(
      name: Routes.updateTaskScreen,
      page: () => UpdateTaskScreen(),
      binding: CrudBinding(),
    ),
  ];
}

class Routes {
  static const splashScreen = '/splashScreen';
  static const loginScreen = '/loginScreen';
  static const homeScreen = '/homeScreen';
  static const addTaskScreen = '/addTaskScreen';
  static const updateTaskScreen = '/updateTaskScreen';
}
