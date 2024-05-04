import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/network/local/casheHelper.dart';
import '../../resourses/styles/colors.dart';
import '../login/login_screen.dart';

class Loc_Permission extends StatefulWidget {
  Loc_Permission({super.key});

  @override
  State<Loc_Permission> createState() => _Loc_PermissionState();
}

class _Loc_PermissionState extends State<Loc_Permission> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Permission.location.request().then((value) {
      if(value.isDenied){
        AppConstants.exitApp();
      }
      if(value.isGranted){
      setState(() {
        CacheHelper.SavaData(key: 'onboard', value: true);
      });
        AppConstants.navigateToAndFinish(context, Login_screen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body:Center(
        child: Image.asset('assets/images/onboard_3.png'),
      )
    );
  }
 
}
