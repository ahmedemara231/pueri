import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/constants/app_constants.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';
import '../message/message_details_screen.dart';
import '../payment/payments_details.dart';

class Doctor_Book extends StatefulWidget {
  @override
  State<Doctor_Book> createState() => _Doctor_BookState();
  Doctor_Book({required this.image,required this.name});
  String? image ;
  String? name ;
}

class _Doctor_BookState extends State<Doctor_Book> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<String> h = [
    '10:00 AM',
    '11:00 AM',
    '8:00 PM',
    '9:00 PM',
  ];
  List<String> d = [
    'Sun 4',
    'Mon 4',
    'Tue 6',
    'Wen 7',
  ];
int d_index =0;
int h_index =0;
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset('assets/images/back_arrow.png')),
                      InkWell(
                          onTap: () {
                            AppConstants.navigateTo(context, Message_Details_Screen(image: '${widget.image}',name: '${widget.name}'));
                          },
                          child: Icon(
                            Icons.email_rounded,
                            color: AppColors.primary,
                          )),
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
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(25),

                            child: Image.asset('${widget.image}',
                            width: 80,
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(width:
                            10),
                            Text(
                              '${widget.name}',
                              style: Styles.semi_bold_16.copyWith(color: Color(0xff091F44)),
                            ),   Text(
                              'Pediatrician',
                              style: Styles.reguler_12.copyWith(color: Color(0xff091F44)),
                            ),
                            Image.asset('assets/images/patients.png')


                          ],
                        ),




                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  date_widget(text: 'Working Hours', onTap: () {}, list: h),
                  SizedBox(
                    height: 10,
                  ),
                  date_widget(text: 'Date', onTap: () {}, list: d,indexx:d_index),
                  SizedBox(
                    height: 20,
                  ),
                  Align(

                      alignment: Alignment.bottomLeft ,child: Text('Price : 500 EGP')),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppConstants.defButton(
                          color: AppColors.primary,
                          onTap: () {
                            AppConstants.navigateTo(
                                context,
                                PaymentDetailsViewBody(
                                  bedId: '',
                                  snapshot: null,
                                  price: 'Pay : 1000 EGP',
                                )
                            );
                            // AppConstants.navigateTo(context, PaymentsDetailsView(price: 'Pay : 500 EGP',onBack: null,));
                          },
                          text: 'Book',
                          condetion: false,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: AppConstants.defButton(
                          color: Colors.white,
                          onTap: () {
                            AppConstants.navigateTo(context, Message_Details_Screen(image: '${widget.image}',name: '${widget.name}',));
                          },
                          textColor: AppColors.primary,
                          text: 'Massage',
                          condetion:false,
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
              ),
            ),
          ),
        ));
      },
    );
  }

  Widget date_widget({onTap, text, required List<String> list,indexx}) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Styles.semi_bold_14,
              ),

            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 52,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(onTap: (){
                  setState(() {
                    if( text =='Date')
                    d_index =index;
                    if( text !='Date')
                    h_index =index;
                   print(d_index==index);
                  });

                },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color:text =='Date' ?d_index==index?  AppColors.primary:Colors.grey :  h_index ==index ?  AppColors.primary:Colors.grey,
                        borderRadius: BorderRadius.circular(18)),
                    height: 50,
                    width: 98,
                    child: Center(
                      child: Text(
                        '${list[index]}',
                        style: Styles.reguler_12
                            .copyWith(fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      );
}
