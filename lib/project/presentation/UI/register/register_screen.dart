import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/Home_Layout.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';


class Register_screen extends StatefulWidget {
  @override
  State<Register_screen> createState() => _Register_screenState();
}

class _Register_screenState extends State<Register_screen> {
  var formKey = GlobalKey<FormState>();

  var email_Controller = TextEditingController();
  var firstName_Controller = TextEditingController();
  var lastName_Controller = TextEditingController();
  var password_Controller = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SignUpSucssesState) {
          AppConstants.navigateToAndFinish(context, HomeLayout());

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 400),
              content: Text(
                'Register_screen Succses ...',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Create New Account',
                            style: Styles.bold_26,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            value.trim().isEmpty) {
                                          return 'please first name ';
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
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: AppColors.primary)),
                                          hintText: 'Frist Name',
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(

                                                color:   AppColors.primary),),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            value.trim().isEmpty) {
                                          return 'please Last name ';
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

                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide(
                                                  color: AppColors.primary)),
                                          hintText: 'Last Name',
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(

                                                color:   AppColors.primary),),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
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
                              if (value == null || value.trim().isEmpty) {
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
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: AppColors.primary)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.red)),
                                 focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(

                                        color:   AppColors.primary),),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: AppColors.primary)),
                                hintText: 'Enter Your Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Password',
                            style: Styles.semi_bold_14,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            style: Styles.semi_bold_14,
                            controller: password_Controller,
                            obscureText: isObscure,
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
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.red)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: AppColors.primary)),
                                 focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(

                                        color:   AppColors.primary),),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: AppColors.primary)),
                                hintText: 'Enter Your Password',
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    child: Icon(isObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppConstants.defButton(
                            color: AppColors.primary,
                            onTap:  () {
                              if(formKey.currentState!.validate()){
                                AppCubit.get(context).signUpAndStoreUserData(
                                    email: email_Controller.text,
                                    first_name: '${firstName_Controller.text}',
                                    password: password_Controller.text,
                                    context: context,
                                    last_name: '${lastName_Controller.text}'
                                );
                              }
                            },
                            text:  'Sign Up',
                            condetion: state is SignUpLodingState,

                          ),

                          Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                height: 20,
                                color: AppColors.grey,
                              )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Or',
                                  style: Styles.reguler_12,
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                height: 20,
                                color: AppColors.grey,
                              )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/fac.png'),
                              Image.asset('assets/images/phone.png'),
                              Image.asset('assets/images/google.png'),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 238,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(104),
                              topLeft: Radius.circular(104))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
