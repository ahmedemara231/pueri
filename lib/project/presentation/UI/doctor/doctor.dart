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
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordScreen(),));
                  },
                  icon: Icon(Icons.add))
            ],
          ),
            body:
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: RefreshIndicator(
                  onRefresh: () => _refreshData(context),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Doctors',
                              style: Styles.semi_bold_20
                                  .copyWith(color: Colors.black),
                            ),
                            Image.asset('assets/images/logo.png'),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
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
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset('assets/images/notification.png')
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {

                              Hospital_Model model_upload = Hospital_Model(
                                topRated: true,
                                avilable: 0,
                                hospital_name: 'katr ElSheikh  Hospital',
                                location:
                                'Kafr El Sheikh, Kafr El Sheikh, ElGish Street',
                                id: '',
                                rate: 3,
                                supported: false, price: '', location_place: '',
                              );
                              cubit.Upload_Hospital(model_upload);
                            },
                            child: SvgPicture.asset('assets/icons/location.svg',
                                color: AppColors.primary),
                          ),
                          Text(
                            ' Kafr ElSheikh',
                            style: Styles.reguler_12
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
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
                          InkWell(
                            onTap: () {
                              AppConstants.navigateTo(context, Doctor_View_All());
                            },
                            child: Text(
                              'View All',
                              style: Styles.semi_bold_14.copyWith(
                                  color: AppColors.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primary),
                            ),
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
