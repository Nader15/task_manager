import 'package:flutter/material.dart';
import '../../Utils/app_colors.dart';

class CustomButton extends StatelessWidget {
   const CustomButton({Key? key, this.title, this.backgroundColor=AppColors.SECOND_COLOR, this.foregroundColor=AppColors.SECOND_COLOR, this.overlayColor=AppColors.SECOND_COLOR,this.onPress, this.borderSideColor=AppColors.SECOND_COLOR}) : super(key: key);
   final title;
   final backgroundColor;
   final foregroundColor;
   final Color? borderSideColor;
   final overlayColor ;
   final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15)),
          overlayColor: MaterialStateProperty.all(
            overlayColor.withOpacity(0.1),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side:  BorderSide(color: borderSideColor!),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
