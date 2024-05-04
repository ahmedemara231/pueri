import 'package:flutter/material.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/models/onboard_model/onboard_model.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import '../loc_permission/loc_permission.dart';

class onboarding extends StatefulWidget {
  onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  List<OnBoarding_Model> onboardList = [
    OnBoarding_Model(
        text: 'An easy-to-use application that anyone can use',
        image: 'assets/images/onboard_1.png'),
    OnBoarding_Model(
        text:
            'All nurseries in hospitals and designated places can be easily reached',
        image: 'assets/images/onboard_2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardList.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(104),
                              bottomRight:  Radius.circular(104)
                          )
                      ),
                      child: Center(
                        child: Image.asset(onboardList[index].image!),
                      ),
                    ), flex: 8),
                    Expanded(
                flex: 2,
                      child: Container(
                          margin: EdgeInsets.all(20),
                          child: Text(
                            onboardList[index].text!,
                            textAlign: TextAlign.center,
                            style: Styles.bold_16.copyWith(color: AppColors.primary),
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap:()async{
                              if (_currentIndex == onboardList.length - 1) {
                                AppConstants.navigateToAndFinish(context, Loc_Permission());
                              } else {
                                _pageController.animateToPage(
                                  _getNextIndex(),
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInExpo,
                                );
                              }


                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              width: 150,
                              height:40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.primary
                              ),
                              child: Center(child: Text('Next',style: Styles.semi_bold_15,textAlign: TextAlign.center)),
                            ),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  int _getNextIndex() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == onboardList.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }
}
