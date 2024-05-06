import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pueri_project/project/app/Home_Layout.dart';
import 'package:pueri_project/project/presentation/UI/admain/password.dart';
import 'package:pueri_project/project/presentation/UI/home/home.dart';
import 'package:pueri_project/project/presentation/UI/login/login_screen.dart';
import 'package:pueri_project/project/presentation/UI/profile/profile.dart';
import 'package:pueri_project/project/presentation/resourses/network/local/casheHelper.dart';
import '../presentation/UI/doctor/doctor.dart';
import '../presentation/UI/splash/splash.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(FirebaseAuth.instance.currentUser?.uid),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home:
            CacheHelper.sharedPreferences.getStringList('userData')!.isEmpty?
            Login_screen  () : HomeLayout(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
