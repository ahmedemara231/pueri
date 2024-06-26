import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pueri_project/project/presentation/UI/admain/password.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/models/hospital_model/hospital_model.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import 'doctor_book.dart';
import 'doctor_components.dart';
import 'doctor_view_all.dart';

class Doctor_Screen extends StatefulWidget {
  @override
  State<Doctor_Screen> createState() => _Doctor_ScreenState();
}

class _Doctor_ScreenState extends State<Doctor_Screen> {
  Future<void> _refreshData(BuildContext context) async {
    AppCubit.get(context).getUserData(FirebaseAuth.instance.currentUser?.uid);
  }

  var searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
            body:
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: RefreshIndicator(
                  onRefresh: () => _refreshData(context),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Doctors',
                            style: Styles.semi_bold_20
                                .copyWith(color: Colors.black),
                          ),
                          const Spacer(),
                          SizedBox(
                            // width: 90,
                              height: 75,
                              child: Image.asset('assets/images/logo.png')),
                        ],
                      ),
              
                      TextFormField(
                        style: Styles.semi_bold_14,
                        controller: searchControler,
                        maxLines: 1,
                        minLines: null,
                        onChanged: (v){
                          setState(() {
                            searchControler.text = v;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter the search query ';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon:
                            Image.asset('assets/images/search.png'),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                BorderSide(color: AppColors.primary)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.red)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide:
                                BorderSide(color: AppColors.primary)),
                            hintText: 'Search',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(

                                  color:   AppColors.primary),),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '',
                            style: Styles.semi_bold_14,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                     Expanded(
                        child: ListView.builder(
                          itemCount: AppConstants.doctors.length,
                          itemBuilder: (context, index) {
                            // print(searchControler.text);
                            // final hospital = cubit.toprated[index];
                            // if (searchControler.text.isNotEmpty && !hospital.hospital_name!.contains(searchControler.text)) { // <-- Add this line
                            //   return SizedBox.shrink(); // Skip this item if it does not match the search query
                            // }
                            return Doctor_widget(
                              name:AppConstants.doctors[index].name ,
                              image_link:AppConstants.doctors[index].image,
                              onTap: () {
                                AppConstants.navigateTo(context, Doctor_Book(image: AppConstants.doctors[index].image,name: AppConstants.doctors[index].name,));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}
