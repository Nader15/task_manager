import 'package:flutter/material.dart';
import '../../../../../../../Utils/app_colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    Key? key,
    this.hintText,
    this.controller,
    this.maxLines,
    this.keyboardType,
  }) : super(key: key);

  final String? hintText;
  final TextEditingController? controller;
  final int? maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: AppColors.MAIN_COLOR, height: .8),
        cursorColor: AppColors.BLACK_COLOR,
        // textAlign: TextAlign.end,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffECECEC)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.MAIN_COLOR),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.GREY_COLOR, fontSize: 13)),
        onChanged: (text) {},
      ),
    );
  }
}
