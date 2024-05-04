import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/cubit/cubit.dart';
import '../../../../app/cubit/state.dart';
import '../../../resourses/styles/colors.dart';
import '../../../resourses/styles/styles.dart';


class Add_Location_Screen extends StatefulWidget {
  Add_Location_Screen({super.key});

  @override
  State<Add_Location_Screen> createState() => _Add_Location_ScreenState();
}

class _Add_Location_ScreenState extends State<Add_Location_Screen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [Image.asset('assets/images/map2.png'),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/images/back_arrow.png')),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Add Location',style: Styles.bold_16.copyWith(color: AppColors.primary,fontSize: 14),),
                    ],
                  ),
                ),



              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
