import 'dart:async';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/cubit/cubit.dart';
import '../../../../app/cubit/state.dart';
import '../../../resourses/constants/app_constants.dart';
import '../../../resourses/models/user/user_model.dart';
import '../../../resourses/styles/colors.dart';
import '../../../resourses/styles/styles.dart';
import 'change_password/change_password.dart';

class Edit_Screen extends StatefulWidget {
  @override
  State<Edit_Screen> createState() => _Edit_ScreenState();
}

class _Edit_ScreenState extends State<Edit_Screen> {
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
  var email_Controller = TextEditingController();
  var firstName_Controller = TextEditingController();
  var lastName_Controller = TextEditingController();
  var password_Controller = TextEditingController();
  var phone_Controller = TextEditingController();
  var date_Controller = TextEditingController();
  String date = '';
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        email_Controller.text = cubit.user_model!.email!;
        firstName_Controller.text = cubit.user_model!.first_name!;
        lastName_Controller.text = cubit.user_model!.last_name!;
        phone_Controller.text = cubit.user_model!.phone!;
        date_Controller.text = cubit.user_model!.date_birth!;
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
                                      'Account',
                                      style: Styles.semi_bold_16.copyWith(
                                          fontSize: 18,
                                          color: AppColors.primary),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(25),
                                          color: AppColors.primary),
                                      child: Text(
                                        'Edit',
                                        style: Styles.reguler_12
                                            .copyWith(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        child: Image.network(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5sauWAwGnkEFOAI_6MfI2MNg8UzIlpbUkTg&usqp=CAU',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Frist Name ',
                                            style: Styles.semi_bold_14,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            style: Styles.semi_bold_14,
                                            controller: firstName_Controller,
                                            maxLines: 1,
                                            minLines: null,
                                            validator: (value) {
                                              if (value == null ||
                                                  value
                                                      .trim()
                                                      .isEmpty) {
                                                return 'please first name ';
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        12),
                                                    borderSide: BorderSide(
                                                        color:
                                                        AppColors.primary)),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                                disabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                    borderSide: BorderSide(
                                                        color:
                                                        AppColors.primary)),
                                                hintText: 'Frist Name',
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(12))),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Last Name ',
                                            style: Styles.semi_bold_14,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            style: Styles.semi_bold_14,
                                            controller: lastName_Controller,
                                            maxLines: 1,
                                            minLines: null,
                                            validator: (value) {
                                              if (value == null ||
                                                  value
                                                      .trim()
                                                      .isEmpty) {
                                                return 'please Last name ';
                                              }

                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        12),
                                                    borderSide: BorderSide(
                                                        color:
                                                        AppColors.primary)),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                                disabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                    borderSide: BorderSide(
                                                        color:
                                                        AppColors.primary)),
                                                hintText: 'Last Name',
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(12))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Email ',
                                  style: Styles.semi_bold_14,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  style: Styles.semi_bold_14,
                                  controller: email_Controller,
                                  maxLines: 1,
                                  minLines: null,
                                  validator: (value) {
                                    if (value == null || value
                                        .trim()
                                        .isEmpty) {
                                      return 'please Enter Email Address';
                                    }
                                    bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value);
                                    if (!emailValid) {
                                      return 'please enter valid email';
                                    }
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
                                      hintText: 'Enter Your Email',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12))),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Data Of Birth Yor Baby ',
                                  style: Styles.semi_bold_14,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1700, 1, 1),
                                        lastDate: DateTime(3000, 1, 1),
                                        initialDate: DateTime.now())
                                        .then((value) {
                                      date_Controller.text =
                                      '${value?.day}/${value?.month}/${value
                                          ?.year}';
                                    });
                                  },
                                  child: TextFormField(
                                    enabled: false,
                                    style: Styles.semi_bold_14,
                                    controller: date_Controller,
                                    maxLines: 1,
                                    minLines: null,
                                    validator: (value) {
                                      if (value == null ||
                                          value
                                              .trim()
                                              .isEmpty) {
                                        return 'please Enter date of birth ';
                                      }

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
                                        hintText: 'DD/MM/YYYY',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(12))),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: (){
                                    AppConstants.navigateTo(context, ChangePassword_Screen());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(9),
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border:
                                        Border.all(color: AppColors.primary)),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Change Password',
                                          style: Styles.semi_bold_16
                                              .copyWith(color: Colors.black),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    User_Model updated_model = User_Model(
                                        first_name: firstName_Controller.text,
                                        last_name: lastName_Controller.text,
                                        id: cubit.user_model?.id,
                                        date_birth: date_Controller.text,
                                        phone: phone_Controller.text,
                                        password: cubit.user_model?.password,
                                        email: email_Controller.text, favorites: cubit.user_model?.favorites ??[]);
                                    if(_formKey.currentState!.validate()){
                                      cubit.UpdateUser(updated_model);
                                    }
                                  },
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
                                        'Update',
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
