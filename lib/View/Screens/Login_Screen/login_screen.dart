import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Routes/routes.dart';
import 'package:task_manager/Utils/app_colors.dart';
import 'package:task_manager/Utils/app_constants.dart';
import 'package:task_manager/Utils/app_images.dart';

import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_textField_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: AppConstants.mediaHeight(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.background_image
                ),
                fit: BoxFit.cover
              )
            ),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                    child: Text(
                      "Login",
                      style: TextStyle(color: AppColors.MAIN_COLOR, fontSize: 30),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: AppConstants.mediaHeight(context)/4),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.WHITE_COLOR,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppConstants.widgetsCurve),
                        topLeft: Radius.circular(AppConstants.widgetsCurve),
                      )
                  ),
                  child: Column(
                    children: [
                      CustomTextFieldWidget(
                        // controller: TextEditingController(text: "Enter your email"),
                        hintText: "Enter your email",
                      ),
                      CustomTextFieldWidget(
                        // controller: TextEditingController(text: "Enter your password"),
                        hintText: "Enter your password",
                      ),
                      SizedBox(height: 20),

                      CustomButton(
                        title: "Sign in",
                        backgroundColor: AppColors.MAIN_COLOR,
                        borderSideColor: AppColors.MAIN_COLOR,
                        foregroundColor: AppColors.WHITE_COLOR,
                        overlayColor: AppColors.WHITE_COLOR,
                        onPress: () {
                          Get.toNamed(Routes.homeScreen);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
