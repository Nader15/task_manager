import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Local_Notifications/local_notifications.dart';
import 'Routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    'resource://drawable/img',
    [
      NotificationChannel(
        channelKey: 'key1',
        channelDescription: 'Notification tests as alerts',
        channelName: 'Basic Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ],
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // AwesomeNotifications().isNotificationAllowed().then(
    //       (isAllowed) {
    //     if (!isAllowed) {
    //       showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: Text('Allow Notifications'),
    //           content: Text('Our app would like to send you notifications'),
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text(
    //                 'Don\'t Allow',
    //                 style: TextStyle(color: Colors.grey, fontSize: 18),
    //               ),
    //             ),
    //             TextButton(
    //               onPressed: () => AwesomeNotifications()
    //                   .requestPermissionToSendNotifications()
    //                   .then((_) => Navigator.pop(context)),
    //               child: Text(
    //                 'Allow',
    //                 style: TextStyle(
    //                   color: Colors.teal,
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks Manager',
      theme: ThemeData(),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    );
  }
}
