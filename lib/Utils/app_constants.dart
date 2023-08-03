import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class AppConstants {
  static const String apiUrl = "https://phpstack-561490-3524079.cloudwaysapps.com/api-start-point/public/api";
  String UserTocken = GetStorage().read<String>('AccessToken')??"";
  static double mediaHeight(context) => MediaQuery.of(context).size.height;
  static double mediaWidth(context) => MediaQuery.of(context).size.width;
  static const double widgetsCurve = 30;
}
