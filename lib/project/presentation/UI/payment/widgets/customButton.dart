import 'package:flutter/material.dart';
import '../../../resourses/styles/colors.dart';
import '../../../resourses/styles/styles.dart';


class customButton extends StatelessWidget {
  final String title;
  final bool isLoading;

  final void Function()? onTap;

  const customButton({
    super.key,
    required this.onTap,
    required this.title,  this.isLoading =false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: ShapeDecoration(
          color: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
          child:isLoading ? CircularProgressIndicator(): Text(
            title,
            textAlign: TextAlign.center,
            style: Styles.style22.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}