// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pueri_project/project/presentation/UI/payment/widgets/payment_details_view_body.dart';
// import '../../../app/cubit/cubit.dart';
// import '../../../app/cubit/state.dart';
//
// class PaymentsDetailsView extends StatelessWidget {
//
//   String? price;
//
//   PaymentsDetailsView({required this.price});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           body: PaymentDetailsViewBody(price: '${price}',),
//         );
//       },
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pueri_project/project/presentation/UI/payment/widgets/customButton.dart';
import 'package:pueri_project/project/presentation/UI/payment/widgets/custom_creditcard.dart';

import '../../../app/cubit/cubit.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';

class PaymentDetailsViewBody extends StatefulWidget {
  PaymentDetailsViewBody({
    required this.price,
    required this.snapshot,
    required this.bedId,
    this.isDoctorBook = false,
    this.doctorName,
    this.day,
    this.time,
    this.timeList,
  });
  String? price;
  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>? snapshot;
  String? bedId;
  bool isDoctorBook;
  String? doctorName;
  String? day;
  String? time;
  List<String>? timeList;

  @override
  State<PaymentDetailsViewBody> createState() => _PaymentDetailsViewBodyState();
}

class _PaymentDetailsViewBodyState extends State<PaymentDetailsViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode =AutovalidateMode.disabled;

  Future<void> decrementBedsCount({
    required String bedId,
    required AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot
  })async
  {
    print(snapshot.data?.data()?['avilable']);

    await FirebaseFirestore.instance.collection('hospitals').doc(bedId).update(
        {
          'avilable' : (snapshot.data?.data()?['avilable'] as int) -1,
        }
    );
  }

  late AppCubit cubit;
  @override
  void initState() {
    cubit = AppCubit.get(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 20,)),
            SliverToBoxAdapter(child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/back_arrow.png')),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width/3.9,
                  ),
                  Text('Payment',style: Styles.bold_16.copyWith(color: AppColors.primary,fontSize: 18),),
                ],
              ),
            ),),
            SliverToBoxAdapter(child: CustomCreditcard(
                formKey: formKey,
                autovalidateMode: autovalidateMode
            )),

            SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:12,right: 16,left: 16 ),
                      child: customButton(onTap: ()async {
                        if(widget.isDoctorBook == false)
                          {
                            await decrementBedsCount(
                                bedId: widget.bedId!,
                                snapshot: widget.snapshot!
                            ).then((value) {
                              Navigator.pop(context);
                            });
                          }
                        else{
                          await cubit.bookDateWithDoctor(
                              name: widget.doctorName!,
                              day: widget.day!,
                              time: widget.time!,
                          );

                          await cubit.showBookedDatesForSpecificDay(
                            name: widget.doctorName!,
                            day: widget.day!,
                            timeList: widget.timeList!,
                          ).then((value) {
                            Navigator.pop(context);
                          });
                        }
                      }, title: '${widget.price}'),
                    ))),
          ],
        ),
      ),
    );
  }
}

