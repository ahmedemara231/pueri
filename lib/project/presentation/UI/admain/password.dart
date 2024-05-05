import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pueri_project/project/presentation/resourses/styles/colors.dart';

import 'all_doctors_books.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter password',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20,),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Pinput(
                defaultPinTheme: PinTheme(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary,width: 1.5),
                  )
                ),
                textInputAction: TextInputAction.done,
                // controller: codeController,
                keyboardType: TextInputType.number,
                length: 6,
                obscuringCharacter: '•',
                autofocus: true,
                pinputAutovalidateMode:
                PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin)
                {
                  if(pin == '000000')
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorsBooks(),
                          ),
                      );
                    }
                  else{
                    SnackBar snackBar = const SnackBar(
                      content: Text('Wrong password'),backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
