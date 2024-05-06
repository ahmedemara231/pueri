import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pueri_project/project/presentation/resourses/network/local/casheHelper.dart';
import '../../../app/Home_Layout.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import '../register/register_screen.dart';

class Login_screen extends StatefulWidget {
  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  var formKey = GlobalKey<FormState>();

  var email_Controller = TextEditingController();

  var password_Controller = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SignINSucssesState) {
          AppConstants.navigateToAndFinish(context, HomeLayout());

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 400),
              content: Text(
                'Login Succses ...',
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
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset('assets/images/logo.png'),
                      Text(
                        'Log In',
                        style: Styles.bold_26,
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
                                borderSide: BorderSide(color: Colors.red)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            hintText: 'Enter Your Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(

                                  color:   AppColors.primary),),
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
                                borderSide: BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            hintText: 'Enter Your Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(

                                  color:   AppColors.primary),),
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
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          if(formKey.currentState!.validate()){
                            AppCubit.get(context).signIN(
                                email: email_Controller.text, password: password_Controller.text, context: context
                            );
                          }

                        },
                        child: Container(
                          width: double.infinity,
                          height:40 ,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
                            child:state is SignINLodingState ? CircularProgressIndicator(color: Colors.white,): Text(
                              'Log in ', style: Styles.semi_bold_15,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(child: Divider(
                            height: 20,
                            color: AppColors.grey,
                          )),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Text('Or',style: Styles.reguler_12,),),
                          Expanded(child: Divider(
                            height: 20,
                            color: AppColors.grey,
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                         Image.asset('assets/images/fac.png'),
                         Image.asset('assets/images/google.png'),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don’t have an account? ',style: Styles.semi_bold_16.copyWith(color: AppColors.grey),),
                          InkWell(
                              onTap: (){
                                AppConstants.navigateTo(context, Register_screen());
                              },
                              child: Text('Sing Up',style: Styles.semi_bold_16,)),
                        ],
                      )
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
