import 'package:flutter/material.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import '../../../app/Home_Layout.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';

class Otp_Screen extends StatefulWidget {
  const Otp_Screen({super.key});

  @override
  State<Otp_Screen> createState() => _Otp_ScreenState();
}

class _Otp_ScreenState extends State<Otp_Screen> {
  var textEditingController = TextEditingController();

  String _otpCode = "";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 238,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(104),
                    bottomRight:  Radius.circular(104)
                )
            ),
            child:   Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Text('OTP Verification',style: Styles.bold_15,),
                  SizedBox(height: 30,),
                ],
              )

          ),
          SizedBox(height: 30,),
          TextFieldPin(
              textController: textEditingController,
              autoFocus: false,
              codeLength: 4,
              alignment: MainAxisAlignment.center,
              defaultBoxSize: 46.0,

              margin: 10,
              selectedBoxSize: 46.0,
              textStyle: TextStyle(fontSize: 16),
              defaultDecoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: AppColors.primary
                    ),
                 )),
              selectedDecoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: AppColors.primary
                    ),
                  )),

              onChange: (code) {
                setState(() {
                  _otpCode = code;

                });
              }),
          SizedBox(height: 40,),
          InkWell(
            onTap: (){
              AppConstants.navigateTo(context, HomeLayout());
            },
            child: Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
               border: Border.all(
                 color: AppColors.primary
               )
              ),
              child: Center(
                child: Text('Confirm',style: TextStyle(
                  color: AppColors.primary
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
