import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:task_manager/Utils/app_images.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  late Timer timer;


  void _goNext() {
    log("From Splash Access Token --> ${GetStorage().read<String>('AccessToken')}");
    if (GetStorage().read<String>('AccessToken') == null){
      Get.offAllNamed(Routes.loginScreen);
    }
    else {
      Get.offAllNamed(Routes.homeScreen);
    }
  }

  startDelay() {
    timer = Timer(const Duration(seconds: 5), _goNext);
  }

  @override
  void initState() {
    GetStorage().read<String>('AccessToken');
    startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.BLACK_COLOR,
      floatingActionButton:  Center(
        heightFactor: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Developed by Nader Salah",
              style: TextStyle(
                color: AppColors.DARK_COLOR,
                fontSize: 10,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "linkedin.com/in/nader15",
              style: TextStyle(
                color: AppColors.DARK_COLOR,
                fontSize: 10,
                decoration: TextDecoration.underline
              ),
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                const Icon(Icons.copyright_outlined,color: AppColors.DARK_COLOR,size: 20,),
                Text(
                  "${DateTime.now().year}",
                  style: const TextStyle(
                    color: AppColors.DARK_COLOR,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Lottie.asset(
                  AppImages.app_logo,height: 100,),
              const SizedBox(height: 20),
              const Text(
                "Tasks Manager",
                style: TextStyle(
                  color: AppColors.MAIN_COLOR,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
