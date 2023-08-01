import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_images.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_textField_widget.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

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
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.arrow_back,color: AppColors.WHITE_COLOR,),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "NEW TASK",
                      style: TextStyle(
                          color: AppColors.MAIN_COLOR, fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: AppConstants.mediaHeight(context)/10,
                  child: ListView.separated(
                      itemCount: 20,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Icon(
                          Icons.circle,
                          color: AppColors.RED_COLOR,
                          size: 30,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: 20,
                      )),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text("Name"),
                      labelStyle: TextStyle(color: AppColors.GREY_COLOR),
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.GREY_COLOR),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.MAIN_COLOR),
                      )
                  ),
                ),
                SizedBox(height: 20),
                Text("Description",style: TextStyle(color: AppColors.GREY_COLOR),),
                SizedBox(height: 10),
                TextFormField(
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
                  onTap: (){
                    log("hi");
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
                  onTap: (){
                    log("hi");
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
                CustomButton(
                  title: "Add Task",
                  backgroundColor: AppColors.MAIN_COLOR,
                  borderSideColor: AppColors.MAIN_COLOR,
                  foregroundColor: AppColors.WHITE_COLOR,
                  overlayColor: AppColors.WHITE_COLOR,
                  onPress: () {
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
