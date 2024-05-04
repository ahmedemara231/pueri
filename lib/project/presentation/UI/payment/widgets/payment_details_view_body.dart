import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../resourses/styles/colors.dart';
import '../../../resourses/styles/styles.dart';
import 'customButton.dart';
import 'custom_creditcard.dart';

class PaymentDetailsViewBody extends StatefulWidget {
  PaymentDetailsViewBody({
    required this.price,
    required this.snapshot,
    required this.bedId,
});
  String? price;
  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot;
  String bedId;

  @override
  State<PaymentDetailsViewBody> createState() => _PaymentDetailsViewBodyState();
}

class _PaymentDetailsViewBodyState extends State<PaymentDetailsViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode =AutovalidateMode.disabled;

  void decrementBedsCount({
    required String bedId,
    required AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot
  })
  {
    FirebaseFirestore.instance.collection('hospitals').doc(bedId).update(
        {
          'avilable' : (snapshot.data?.data()?['avilable'] as int) -1,
        }
    );
    print(snapshot.data?.data()?['avilable']);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 20,)),
          SliverToBoxAdapter(child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      decrementBedsCount(bedId: widget.bedId, snapshot: widget.snapshot);
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
                child: customButton(onTap: () {
                  Navigator.pop(context);
                }, title: '${widget.price}'),
              ))),
        ],
      ),
    );
  }
}
