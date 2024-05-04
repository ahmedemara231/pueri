import 'dart:async';
import 'package:buildcondition/buildcondition.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import '../contact/contact_us.dart';
import '../favorite_screen/favorite_screen.dart';
import '../location/location.dart';
import '../login/login_screen.dart';
import '../payment/payments_details.dart';
import 'edit/edit.dart';

class Profile_Screen extends StatefulWidget {
  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
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
          body:
          // Container(
          //   color: Colors.white,
          // )
          SafeArea(
            child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () => _refreshData(context),
                child: state is GetUserDataLodingState
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : BuildCondition(
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  AppConstants.navigateTo(
                                      context, Edit_Screen());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border:
                                          Border.all(color: AppColors.primary)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5sauWAwGnkEFOAI_6MfI2MNg8UzIlpbUkTg&usqp=CAU',
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.fill,
                                          )),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${cubit.user_model?.first_name} ${cubit.user_model?.last_name}',
                                            style: Styles.semi_bold_16
                                                .copyWith(color: Colors.black),
                                          ),
                                          Text(
                                            '${cubit.user_model?.email}',
                                            style: Styles.reguler_12
                                                .copyWith(fontSize: 11)
                                                .copyWith(color: Colors.black),
                                          )
                                        ],
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
                              profile_item(
                                  icon: Icons.headset_outlined,
                                  color: Colors.blue,
                                  text: 'Contact Us',
                                  onTap: () {
                                    AppConstants.navigateTo(context, ContactUsScreen());
                                  }),
                              profile_item(
                                  icon: Icons.payment_outlined,
                                  color: Colors.black,
                                  text: 'Payment Methoud',
                                  onTap: () {
                                    // AppConstants.navigateTo(
                                    //     context,
                                    //
                                    //     PaymentsDetailsView(price: 'Add',onBack: null,)
                                    // );
                                    AppConstants.navigateTo(
                                        context,
                                        PaymentDetailsViewBody(
                                          bedId: '',
                                          snapshot: null,
                                          price: 'Pay : 1000 EGP',
                                        )
                                    );
                                  }),
                              profile_item(
                                  icon: Icons.favorite_border_outlined,
                                  color: Colors.red,
                                  text: 'Favorite',
                                  onTap: () {
                                    AppConstants.navigateTo(context, Favorite_Screen());
                                  }),
                              profile_item(
                                  icon: Icons.location_on_outlined,
                                  color: Colors.green,
                                  text: 'Location',
                                  onTap: () {
                                    AppConstants.navigateTo(context, Location_Screen());
                                  }),
                              profile_item(
                                  icon: Icons.logout_outlined,
                                  color: Colors.red,
                                  text: 'Log Out',
                                  onTap: () async{
                                   await FirebaseAuth.instance.signOut().then((value)  {
                                     cubit. bottomNavIndex = 0;
                                     cubit.favorite_list = [];
                                              AppConstants.navigateToAndFinish(
                                                  context, Login_screen());
                                            });
                                  }),

                            ],
                          ),
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        condition: true, //cubit.student_model !=null,
                      )),
          ),
        );
      },
    );
  }

  Widget profile_item({icon, text, onTap, color}) => InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(9),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.primary)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                text,
                style: Styles.semi_bold_16.copyWith(color: Colors.black),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      );
}
