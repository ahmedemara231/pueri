import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pueri_project/project/presentation/UI/watch/watch_widget_screen.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';


class Watch_Screen extends StatefulWidget {
  @override
  State<Watch_Screen> createState() => _Watch_ScreenState();
}

class _Watch_ScreenState extends State<Watch_Screen> {

  Future<void> _refreshData(BuildContext context) async {
    AppCubit.get(context).getUserData(AppCubit.get(context).user_model?.id);

  }

  var controler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {

      },
      builder: (context, state) {

        var cubit  =AppCubit.get(context);

        return Scaffold(
          appBar:AppBar(),

          body:
          RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () => _refreshData(context),
              child: state is GetUserDataLodingState ?Center(child: CircularProgressIndicator(),): Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('serial number',style: Styles.bold_16.copyWith(color: Colors.black),),
                      SizedBox(height: MediaQuery.sizeOf(context).height/14,),
                      TextFormField(
                        style: Styles.semi_bold_14,
                        controller: controler,
                        maxLines: 1,
                        minLines: null,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'please enter serial number ';
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
                            hintText: 'XX/XX/X',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                  
                                  color:   AppColors.primary),),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12))),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height/13,),
                      Row(
                        children: [
                          Expanded(
                            child: AppConstants.defButton(
                              color:Colors.white,
                              onTap: () {
                  AppConstants.navigateTo(context, Watch__Widget_Screen());
                              },
                              textColor: AppColors.primary,
                              text: 'Confirm',
                              condetion: false,
                            ),
                          ),
                  
                  
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
