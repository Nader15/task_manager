import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constants.dart';
import '../../../Utils/app_images.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_textField_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TODO",
                              style: TextStyle(
                                  color: AppColors.MAIN_COLOR, fontSize: 30),
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
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Icon(Icons.add,color: AppColors.WHITE_COLOR,),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today",
                              style: TextStyle(
                                  color: AppColors.BLACK_COLOR, fontSize: 20),
                            ),
                            Text(
                              "Monday, 1, June",
                              style: TextStyle(
                                  color: AppColors.MAIN_COLOR, fontSize: 15),
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
                                return Container(
                                  width: 50,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: index==2?AppColors.MAIN_COLOR:AppColors.WHITE_COLOR,
                                      border: Border.all(color: AppColors.MAIN_COLOR),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(index<9?"0${index+1}":"${index+1}",style: TextStyle(color: index==2?AppColors.WHITE_COLOR:AppColors.MAIN_COLOR,fontSize: 20),),
                                      SizedBox(height: 5,),
                                      Text("M",style: TextStyle(color: index==2?AppColors.WHITE_COLOR:AppColors.MAIN_COLOR),),
                                    ],
                                  )
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                width: 20,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: AppConstants.mediaHeight(context) / 3),
                  decoration: BoxDecoration(
                      color: AppColors.WHITE_COLOR,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppConstants.widgetsCurve),
                        topLeft: Radius.circular(AppConstants.widgetsCurve),
                      )),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: (){
                              Get.toNamed(Routes.updateTaskScreen);
                            },
                            leading: Icon(
                              Icons.circle,
                              color: AppColors.RED_COLOR,
                            ),
                            title: Text("food for the week ..."),
                            trailing:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("20 June",style: TextStyle(fontWeight: FontWeight.bold),) ,
                                Text("14:26",style: TextStyle(color: AppColors.GREY_COLOR),) ,
                              ],
                            ) ,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 20,
                          )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
