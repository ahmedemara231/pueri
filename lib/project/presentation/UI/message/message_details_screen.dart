import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';

class Message_Details_Screen extends StatefulWidget {
  @override
  State<Message_Details_Screen> createState() => _Message_Details_ScreenState();
  Message_Details_Screen({required this.image,required this.name});
  String? name;
  String? image;
}

class _Message_Details_ScreenState extends State<Message_Details_Screen> {
  List<String> messages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                color: AppColors.primary,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/back_arrow.png',
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                            width: 40,
                            child: Image.asset(
                              '${widget.image}'
                            ))),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${widget.name}',
                      style: Styles.semi_bold_15,
                    ),
                    Spacer(),
                    SizedBox(
                        width: 40,
                        child: Image.asset(
                          'assets/images/icon_phone.png',
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        width: 40,
                        child: Image.asset(
                          'assets/images/vidio.png',
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Column(
                children: [
                  message_widget('To day'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: message_widget('مرحبا بك')),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) => Align(
                    alignment: Alignment.centerRight,
                    child: message_widget('${messages[index]}')),
              )),
              Container(
                color: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 1.9,
                      child: TextFormField(
                        style: Styles.semi_bold_14,
                        controller: controler,
                        maxLines: 1,
                        minLines: null,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please enter message';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.white)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.red)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: 'Message',
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        width: 40,
                        child: Image.asset(
                          'assets/images/cam.png',
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        width: 40,
                        child: Image.asset(
                          'assets/images/vidio.png',
                          color: Colors.white,
                        )),
                    InkWell(
                      onTap: (){
                        messages.add(controler.text);
                        setState(() {
                          controler.clear();
                        });
                      },
                      child: SizedBox(
                          width: 40,
                          child: Icon(
                            Icons.send_outlined,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      },
    );
  }

  Widget message_widget(text) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          style: Styles.semi_bold_14.copyWith(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      );
}
