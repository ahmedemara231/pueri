import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../app/Home_Layout.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import '../login/login_screen.dart';
import '../onboarding/onboarding.dart';

class Splash_Screen extends StatefulWidget {
  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 600), _goNext);
  }
  _goNext() {
      AppConstants.navigateToAndFinish(context, AppConstants.onboarding ? FirebaseAuth.instance.currentUser!=null ? HomeLayout(): Login_screen():onboarding());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:
          Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(104),
                  bottomRight:  Radius.circular(104)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Text('Welcome',style: Styles.bold_15,),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Image.asset(
                  'assets/images/logo.png'

              ),
            ),
          ),
          Expanded(
            child: Container( width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(104),
                      topLeft:  Radius.circular(104)
                  )
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text('Nursery Care App',style: Styles.bold_15,)
                ],
              ),
            ),
          ),
        ],
      )
      ),
    );
  }
}
