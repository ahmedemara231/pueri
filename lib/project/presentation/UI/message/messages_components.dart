import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pueri_project/project/presentation/resourses/network/local/casheHelper.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';

class Messages_widget extends StatelessWidget {
  Messages_widget(
      {required this.image_link,
      required this.message,
      required this.date,
      required this.num,
      required this.name,
      required this.onTap});

  String? image_link;
  void Function()? onTap;
  String? name;
  String? message;
  int? num;
  String? date;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child:
                    SizedBox(width: 70, child: Image.asset('${image_link}'))),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${name}',
                  style: Styles.bold_16.copyWith(color: Colors.black),
                ),
                Text(
                  'Welcome ${CacheHelper.sharedPreferences.getStringList('userData')![1]} !',
                  style: Styles.reguler_12.copyWith(color: Colors.grey),
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
