import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import 'home_components.dart';
import 'home_widget_screen.dart';

class Home_View_All extends StatefulWidget {
  Home_View_All({super.key});

  @override
  State<Home_View_All> createState() => _Home_View_AllState();
}

class _Home_View_AllState extends State<Home_View_All> {
  var searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:cubit.hospitals.isEmpty? Center(child: CircularProgressIndicator(),): Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/images/back_arrow.png')),

                  ],
                ),
                SizedBox(
                  height: 10,
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
                      prefixIcon: Image.asset('assets/images/search.png'),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: AppColors.primary)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.red)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: AppColors.primary)),
                      hintText: 'Search',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(

                            color:   AppColors.primary),),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index)
                      {
                        final hospital = cubit.hospitals[index];
                        if (searchControler.text.isNotEmpty && !hospital.hospital_name!.contains(searchControler.text)) { // <-- Add this line
                          return SizedBox.shrink(); // Skip this item if it does not match the search query
                        }
                        if (!(hospital.location_place == cubit.place_filter)) { // <-- Add this line
                          return SizedBox.shrink(); // Skip this item if it does not match the search query
                        }
                        return InkWell(
                            onTap: (){
                          AppConstants.navigateTo(context, Home_Widget_Screen(model:cubit.hospitals[index]));
                        },
                        child:  Home_widget(
                        hospital_name:
                        '${cubit.hospitals[index].hospital_name}',
                        beds: cubit.hospitals[index].avilable!,
                        id: cubit.hospitals[index].id!,
                        location: '${cubit.hospitals[index].location}',
                        rate: cubit.hospitals[index].rate!,
                        ));},
                      itemCount: cubit.hospitals.length,
                    ))
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {

    },);
  }
}
