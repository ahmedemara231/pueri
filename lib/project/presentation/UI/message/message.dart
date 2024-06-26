import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pueri_project/project/presentation/resourses/styles/colors.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/models/hospital_model/hospital_model.dart';
import '../../resourses/styles/styles.dart';
import 'message_details_screen.dart';
import 'messages_components.dart';
class Message_Screen extends StatefulWidget {
  @override
  State<Message_Screen> createState() => _Message_ScreenState();
}

class _Message_ScreenState extends State<Message_Screen> {
  Future<void> _refreshData(BuildContext context) async {
    AppCubit.get(context).getUserData(FirebaseAuth.instance.currentUser?.uid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


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
                      Container(
                        width: double.infinity,
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Message',
                              style: Styles.semi_bold_20
                                  .copyWith(color: Colors.black),
                            ),
                            Image.asset('assets/images/logo.png'),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      cubit.topRated.isEmpty
                          ? Center(
                        child: CircularProgressIndicator(),
                      )
                          : Expanded(
                        child: ListView.builder(
                          itemCount: AppConstants.doctors.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  AppConstants.navigateTo(context, Message_Details_Screen(name:AppConstants.doctors[index].name ,
                                            image:AppConstants.doctors[index].image));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: AppColors.primary),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(AppConstants.doctors[index].image!),
                                      ),
                                      title: Text(AppConstants.doctors[index].name!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                      trailing: const Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ),
                              ),
                            );
                            // return Messages_widget( message: 'مرحبا', date: '12:50', num: 1,
                            //   name:AppConstants.doctors[index].name ,
                            //   image_link:AppConstants.doctors[index].image,
                            //   onTap: () {
                            //   AppConstants.navigateTo(context, Message_Details_Screen(name:AppConstants.doctors[index].name ,
                            //       image:AppConstants.doctors[index].image));
                            //
                            //   },
                            // );
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
