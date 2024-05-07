import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import 'add_location/add_location.dart';
import 'location_widget.dart';

class Location_Screen extends StatefulWidget {
  Location_Screen({super.key});

  @override
  State<Location_Screen> createState() => _Location_ScreenState();
}

class _Location_ScreenState extends State<Location_Screen> {
  List<String> loc = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/images/back_arrow.png')),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width/3.9,
                      ),
                      Text('Location',style: Styles.bold_16.copyWith(color: AppColors.primary,fontSize: 18),),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: AppConstants.locations.length,
                      itemBuilder: (context, index) {
                        return Location_widget(
                          text: AppConstants.locations[index],
                          visable: AppCubit.get(context).place_filter == AppConstants.locations[index],
                          onTap: () {
                            setState(() {

                              AppCubit.get(context).ChangeLocation(AppConstants.locations[index]);
                              print(AppConstants.locations[index]);
                              print(AppCubit.get(context).place_filter);
                              Navigator.pop(context);
                            });
                          },
                        );
                      },),
                  ),
                  InkWell(
                    onTap: (){
                      AppConstants.navigateTo(context, Add_Location_Screen());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: AppColors.primary)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/location.svg',
                              color: Colors.black),
                          SizedBox(width:
                          10),
                          Text(
                            'Add Location',
                            style: Styles.semi_bold_20.copyWith(color: AppColors.primary),
                          ),


                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
