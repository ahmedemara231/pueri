import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';

class Watch__Widget_Screen extends StatefulWidget {
  @override
  State<Watch__Widget_Screen> createState() => _Watch__Widget_ScreenState();
}

class _Watch__Widget_ScreenState extends State<Watch__Widget_Screen> {
  Future<void> _refreshData(BuildContext context) async {
    AppCubit.get(context).getUserData(AppCubit.get(context).user_model?.id);
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
          body: SafeArea(
            child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () => _refreshData(context),
                child: state is GetUserDataLodingState
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Image.asset(
                                        'assets/images/back_arrow.png')),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Today',
                                  style: Styles.bold_16
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            heart_widget(text: '8:30',text1: '77 BPM'),
                            heart_widget(text: '10:00',text1: '66 BPM'),
                            heart_widget(text: '9:45',text1: '36 ms'),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: AppColors.primary)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.hotel_sharp,
                                          color: Color(0xff276F77)),
                                      Text(
                                        'Sleep',
                                        style: Styles.semi_bold_16
                                            .copyWith(color: Color(0xff276F77)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                      Text(
                                        '8:00 Hr',
                                        style: Styles.bold_16
                                            .copyWith(color: Colors.black),
                                      ),

                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: AppColors.primary)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/images/temp.png',
                                          color: Color(0xff35B416)),
                                      Text(
                                        'Temperature',
                                        style: Styles.semi_bold_16
                                            .copyWith(color: Color(0xff35B416)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                      Text(
                                        '35°C',
                                        style: Styles.bold_16
                                            .copyWith(color: Colors.black),
                                      ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      )),
          ),
        );
      },
    );
  }
  Widget heart_widget({text, text1})=> Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.primary)),
    child: Column(
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.favorite,
                    color: Colors.red),
                Text(
                  'Heart Rate',
                  style: Styles.semi_bold_16
                      .copyWith(color: Colors.red),
                ),
              ],
            ),
            Text(
              '$text',
              style: Styles.semi_bold_16
                  .copyWith(color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              '$text1',
              style: Styles.bold_16
                  .copyWith(color: Colors.black),
            ),
          ],
        ),
      ],
    ),
  );
}
