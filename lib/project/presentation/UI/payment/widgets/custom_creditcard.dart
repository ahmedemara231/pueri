import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';


class CustomCreditcard extends StatefulWidget {
  CustomCreditcard({Key? key, required this.formKey, required this.autovalidateMode}) : super(key: key);
  final GlobalKey<FormState> formKey ;
 final  AutovalidateMode autovalidateMode ;

  @override
  State<CustomCreditcard> createState() => _CustomCreditcardState();
}

class _CustomCreditcardState extends State<CustomCreditcard> {
   String cardNumber = '',
      expiryDate = '',
      cardHolderName = '',
      cvvCode = '';

   bool showBackView = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: showBackView,
            isHolderNameVisible: true,
            onCreditCardWidgetChange: (v) {}),

        CreditCardForm(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            autovalidateMode:    widget.autovalidateMode,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (creditCardModel) {
              cardNumber = creditCardModel.cardNumber;
              expiryDate = creditCardModel.expiryDate;
              cardHolderName = creditCardModel.cardHolderName;
              cvvCode = creditCardModel.cvvCode;
              showBackView = creditCardModel.isCvvFocused;
              setState(() {

              });
            },
            formKey: widget.formKey
        ),

      ],
    );
  }
}
