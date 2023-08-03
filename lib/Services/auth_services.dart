import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import '../Models/login_model.dart';
import 'package:http/http.dart' as http;
import '../Utils/app_constants.dart';

class AuthServices {
  Future<LoginModel> loginAPI(
      String Email,
      String Password,
      context) async {
    var data = await http.post(
      Uri.parse(AppConstants.apiUrl + '/auth/login'),
      body: {
        'email': Email,
        'password': Password,
      },
    );
    var jsonData = json.decode(data.body);
    var decodedData = jsonDecode(data.body);

    if (decodedData['status'] ) {
      return LoginModel.fromJson(jsonData);
    } else {
      return LoginModel.fromJson(jsonData);
    }
  }
}