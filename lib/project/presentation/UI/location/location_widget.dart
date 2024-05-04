import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';

class Location_widget extends StatelessWidget {
  Location_widget({required this.text ,required this.onTap ,required this.visable,});

  String text= '';
  void Function()? onTap;

  bool visable= true;


  @override
  Widget build(BuildContext context) {
    return    InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.primary)
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/icons/location.svg',
                    color: Colors.black),
                SizedBox(width:
                10),
                Text(
                  '${text}',
                  style: Styles.semi_bold_20.copyWith(color: Colors.black),
                ),
      Spacer(),
                if(!visable)
                Icon(Icons.delete_sharp,color: Colors.red,)

              ],
            ),
            if(visable)
            SizedBox(
              height: 15,
            ),
            Visibility(
                visible: visable,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset('assets/images/map.png')))

          ],
        ),
      ),
    );
  }
}
