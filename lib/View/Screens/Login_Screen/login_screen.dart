import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Routes/routes.dart';
import 'package:task_manager/Utils/app_colors.dart';
import 'package:task_manager/Utils/app_constants.dart';
import 'package:task_manager/Utils/app_images.dart';

import '../../../Logic/controllers/auth_controller.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_circle_progress.dart';
import '../../Widgets/custom_textField_widget.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      controller: authController.loginEmailController.value,
                      hintText: "Enter your email",
                    ),
                    CustomTextFieldWidget(
                      controller: authController.loginPasswordController.value,
                      hintText: "Enter your password",
                    ),
                    SizedBox(height: 20),

                    Obx(
                          () => ConditionalBuilder(
                        condition: !authController.isLogInLoading.value,
                        builder: (context) =>  CustomButton(
                          title: "Sign in",
                          backgroundColor: AppColors.MAIN_COLOR,
                          borderSideColor: AppColors.MAIN_COLOR,
                          foregroundColor: AppColors.WHITE_COLOR,
                          overlayColor: AppColors.WHITE_COLOR,
                          onPress: () {
                            authController.login(
                                authController.loginEmailController.value.text,
                                authController.loginPasswordController.value.text,
                                context
                            );
                          },
                        ),
                        fallback: (context) => const CustomCircleProgress(),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
