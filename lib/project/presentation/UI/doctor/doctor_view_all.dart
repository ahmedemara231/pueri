import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import 'doctor_book.dart';
import 'doctor_components.dart';

class Doctor_View_All extends StatefulWidget {
  Doctor_View_All({super.key});

  @override
  State<Doctor_View_All> createState() => _Doctor_View_AllState();
}

class _Doctor_View_AllState extends State<Doctor_View_All> {
  var searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: cubit.hospitals.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Row(
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
                          height: 10,
                        ),
                        TextFormField(
                          style: Styles.semi_bold_14,
                          controller: searchControler,
                          maxLines: 1,
                          minLines: null,
                          onChanged: (v) {
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
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: ListView.builder(
                          itemBuilder: (context, index) {
                            final hospital = cubit.hospitals[index];
                            if (searchControler.text.isNotEmpty &&
                                !hospital.hospital_name!
                                    .contains(searchControler.text)) {
                              // <-- Add this line
                              return SizedBox
                                  .shrink(); // Skip this item if it does not match the search query
                            }
                            return Doctor_widget(
                              name: AppConstants.doctors[index].name,
                              image_link: AppConstants.doctors[index].image,
                              onTap: () {
                                AppConstants.navigateTo(
                                    context,
                                    Doctor_Book(
                                      image: AppConstants.doctors[index].image,
                                      name: AppConstants.doctors[index].name,
                                    ));
                              },
                            );
                          },
                          itemCount:  AppConstants.doctors.length,
                        ))
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
