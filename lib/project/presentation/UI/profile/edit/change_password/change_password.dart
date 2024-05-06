import 'dart:async';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/cubit/cubit.dart';
import '../../../../../app/cubit/state.dart';
import '../../../../resourses/styles/colors.dart';
import '../../../../resourses/styles/styles.dart';


class ChangePassword_Screen extends StatefulWidget {
  @override
  State<ChangePassword_Screen> createState() => _ChangePassword_ScreenState();
}

class _ChangePassword_ScreenState extends State<ChangePassword_Screen> {
  Future<void> _refreshData(BuildContext context) async {
    AppCubit.get(context).getUserData(AppCubit
        .get(context)
        .user_model
        ?.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var _formKey = GlobalKey<FormState>();

  var NewPassword_Controller = TextEditingController();
  var ConfirmPasswrod_Controller = TextEditingController();
  var password_Controller = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);


        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () => _refreshData(context),
                child: state is GetUserDataLodingState
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : BuildCondition(
                  builder: (context) =>
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Image.asset(
                                            'assets/images/back_arrow.png')),
                                    Text(
                                      'Change Password',
                                      style: Styles.semi_bold_16.copyWith(
                                          fontSize: 18,
                                          color: AppColors.primary),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),

                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),


                                Text(
                                  'Old Password ',
                                  style: Styles.semi_bold_14,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  style: Styles.semi_bold_14,
                                  controller: password_Controller,
                                  maxLines: 1,
                                  minLines: null,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please Enter Password';
                                    }
                                    if (value.length < 6) {
                                      return 'password should be at least 6 character';
                                    }
                                    return null;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColors.primary)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide:
                                          BorderSide(color: Colors.red)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColors.primary)),
                                      hintText: 'Enter Your old Password',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12))),
                                ),

                                SizedBox(
                                  height: 20,
                                ),


                                Text(
                                  'New Password ',
                                  style: Styles.semi_bold_14,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  style: Styles.semi_bold_14,
                                  controller: NewPassword_Controller,
                                  maxLines: 1,
                                  minLines: null,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please Enter Password';
                                    }
                                    if (value.length < 6) {
                                      return 'password should be at least 6 character';
                                    }
                                    return null;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColors.primary)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide:
                                          BorderSide(color: Colors.red)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColors.primary)),
                                      hintText: 'Enter Your New Password',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12))),
                                ),

                                SizedBox(
                                  height: 20,
                                ),


                                Text(
                                  'Confirmed Password ',
                                  style: Styles.semi_bold_14,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  style: Styles.semi_bold_14,
                                  controller: NewPassword_Controller,
                                  maxLines: 1,
                                  minLines: null,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'please Enter Password';
                                    }
                                    if (value.length < 6) {
                                      return 'password should be at least 6 character';
                                    }
                                    return null;
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColors.primary)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide:
                                          BorderSide(color: Colors.red)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: AppColors.primary)),
                                      hintText: 'Enter Your Confirmed Password',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12))),
                                ),


                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius:
                                        BorderRadius.circular(12)),
                                    child: Center(
                                      child: state is UpdateLoadingState
                                          ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                          : Text(
                                        'Change password',
                                        style: Styles.semi_bold_15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  fallback: (context) =>
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                  condition: true, //cubit.student_model !=null,
                )),
          ),
        );
      },
    );
  }
}
