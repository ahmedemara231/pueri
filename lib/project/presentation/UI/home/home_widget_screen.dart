import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pueri_project/project/presentation/UI/profile/profile.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/models/hospital_model/hospital_model.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import '../payment/payments_details.dart';
import 'home_components.dart';

class Home_Widget_Screen extends StatefulWidget {
    Home_Widget_Screen({required this.model});
  Hospital_Model? model;
  @override
  State<Home_Widget_Screen> createState() => _Home_Widget_ScreenState();
}

class _Home_Widget_ScreenState extends State<Home_Widget_Screen> {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
                      stream: FirebaseFirestore.instance.collection('hospitals').doc(widget.model?.id).snapshots(),
                      builder: (context, snapshot) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset('assets/images/back_arrow.png')),

                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Home_widget(
                            hospital_name:
                            '${widget.model?.hospital_name}',
                            beds: snapshot.data?.data()?['avilable'],
                            id: widget.model?.id!,
                            location: '${widget.model?.location}, ${widget.model?.subLocation}',
                            rate: widget.model?.rate!,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width-40,
                            height: 111,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: image_list.length,
                              itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset('${image_list[index]}')),
                              );
                            },),

                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(

                              alignment: Alignment.bottomLeft ,child: Text('Price : ${widget.model?.price} EGP')),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AppConstants.defButton(
                                  color:widget.model?.avilable =='0' ? Colors.grey: AppColors.primary,
                                  onTap: () {
                                    // FirebaseFirestore.instance.collection('hospitals').doc(widget.model?.id).update(
                                    //     {
                                    //       'avilable' : (snapshot.data?.data()?['avilable'] as int) -1,
                                    //     }
                                    // );
                                    // print(snapshot.data?.data()?['avilable']);
                                    if(widget.model?.avilable != 0) {
                                      AppConstants.navigateTo(
                                          context,
                                          PaymentDetailsViewBody(
                                            bedId: widget.model!.id,
                                            snapshot: snapshot,
                                            price: widget.model!.price,
                                          )
                                      );
                                    }
                                  },
                                  text: 'Book',
                                  condetion: false,
                                ),
                              ),


                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            width: double.infinity,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: AppColors.primary)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [

                                    SizedBox(width:
                                    10),
                                    Text(
                                      'Location',
                                      style: Styles.semi_bold_16.copyWith(color: Colors.grey),
                                    ),


                                  ],
                                ),

                                SizedBox(
                                  height: 15,
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.asset('assets/images/map.png'))

                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  ),
                ),
              ),
            ));
      },
    );
  }
List<String> image_list = [
  'assets/images/hospital_image1.png',
  'assets/images/hospital_image2.png',
];
}
