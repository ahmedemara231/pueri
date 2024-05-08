import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import '../home/home_components.dart';
import '../home/home_widget_screen.dart';

class Favorite_Screen extends StatefulWidget {
  Favorite_Screen({super.key});

  @override
  State<Favorite_Screen> createState() => _Favorite_ScreenState();
}

class _Favorite_ScreenState extends State<Favorite_Screen> {
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
                        final hospital = cubit.favorite_list[index];

                        if (searchControler.text.isNotEmpty && !hospital.hospital_name!.contains(searchControler.text)) { // <-- Add this line
                          return SizedBox.shrink(); // Skip this item if it does not match the search query
                        }
                        return InkWell(
                          onTap: (){
                            AppConstants.navigateTo(context, Home_Widget_Screen(model:cubit.favorite_list[index]));
                          },
                          child: Home_widget(
                            hospital_name:
                            '${cubit.favorite_list[index].hospital_name}',
                            beds: cubit.favorite_list[index].avilable!,
                            id: cubit.favorite_list[index].id!,
                            location: '${cubit.favorite_list[index].location}, ${cubit.favorite_list[index].subLocation}',
                            rate: cubit.favorite_list[index].rate!,
                          ),
                        );},
                      itemCount: cubit.favorite_list.length,
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
