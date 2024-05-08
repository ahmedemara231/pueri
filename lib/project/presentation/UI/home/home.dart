import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/models/hospital_model/hospital_model.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import '../location/location.dart';
import '../notification/notification_screen.dart';
import 'home_components.dart';
import 'home_view_all.dart';
import 'home_widget_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshData(BuildContext context) async {
    await AppCubit.get(context).getUserData(FirebaseAuth.instance.currentUser?.uid);
    // await AppCubit.get(context).getTopRatedBasedOnLocation();
    await AppCubit.get(context).Get_Hospital();
  }

  late AppCubit cubit;
  @override
  void initState() {
    cubit = AppCubit.get(context);
    _refreshData(context);

    super.initState();
  }

  var searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: Styles.semi_bold_20
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              '${cubit.user_model?.first_name} ${cubit.user_model?.last_name}',
                              style: Styles.reguler_12
                                  .copyWith(color: Colors.black),
                            )
                          ],
                        ),
                        InkWell(
                            onTap: null,
                            child: Image.asset('assets/images/logo.png')),
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


                              cubit.search(v);


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
                                  borderSide: BorderSide(
                                      color:   AppColors.primary),
                                  borderRadius:
                                  BorderRadius.circular(25)),
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(25))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      AppConstants.navigateTo(context, Location_Screen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                         SvgPicture.asset('assets/icons/location.svg',
                              color: AppColors.primary),

                        Text(
                          cubit.place_filter,
                          style: Styles.reguler_12
                              .copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'High Rated Nursery',
                        style: Styles.semi_bold_14,
                      ),
                      InkWell(
                        onTap: () {
                          AppConstants.navigateTo(context, Home_View_All());
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
                  const SizedBox(
                    height: 20,
                  ),
                  state is get_Hos_LoadingState?
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: cubit.finalListFiltering.isEmpty?

                          const Center(
                            child: Text('No results',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
                          ) :
                          ListView.builder(
                            itemCount: cubit.finalListFiltering.length,
                            itemBuilder: (context, index) {
                              // final hospital = cubit.finalListFiltering[index];
                              // if (searchControler.text.isNotEmpty && hospital.hospital_name.contains(searchControler.text)) { // <-- Add this line
                              //   return SizedBox.shrink();
                              //   // Skip this item if it does not match the search query
                              // }if ((hospital.location_place == cubit.place_filter)){ // <-- Add this line
                              //   return SizedBox.shrink(); // Skip this item if it does not match the search query
                              // }
                              return InkWell(
                                onTap: (){
                                  AppConstants.navigateTo(context, Home_Widget_Screen(model:cubit.finalListFiltering[index]));
                                },
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance.collection('hospitals').doc(cubit.finalListFiltering[index].id).snapshots(),
                                  builder: (context, snapshot) {
                                    return Home_widget(
                                      hospital_name:
                                      '${cubit.finalListFiltering[index].hospital_name}',
                                      beds: snapshot.data?.data()?['avilable'],
                                      id: cubit.finalListFiltering[index].id!,
                                      location: '${cubit.finalListFiltering[index].location}, ${cubit.finalListFiltering[index].subLocation}',
                                      rate: cubit.finalListFiltering[index].rate!,
                                    );
                                  }
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
