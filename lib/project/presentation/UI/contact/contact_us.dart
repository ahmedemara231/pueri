import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/cubit/cubit.dart';
import '../../../app/cubit/state.dart';
import '../../resourses/styles/colors.dart';
import '../../resourses/styles/styles.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  final TextEditingController messageController = TextEditingController();
  var _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset('assets/images/back_arrow.png')),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width/3.9,
                          ),
                          Text('Contact Us',style: Styles.bold_16.copyWith(color: AppColors.primary,fontSize: 18),),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        " Name",
                        textAlign: TextAlign.left,

                      ),
                      SizedBox(height:16),
                      TextFormField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        focusNode: _focusNode1,
                        onFieldSubmitted: (v){
                          FocusScope.of(context).requestFocus(_focusNode2);
            
                        },
                        autofocus: true,
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
            
                        style: Styles.semi_bold_14,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: AppColors.primary)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.red)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: AppColors.primary)),
                            hintText: 'Your Name',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
            
                                  color:   AppColors.primary),),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12))),
                      ),
                      SizedBox(height: 18),
                      Text(
                        " Email",
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height:16),
                      TextFormField(
                        focusNode: _focusNode2,
                        onFieldSubmitted: (v){
                          FocusScope.of(context).requestFocus(_focusNode3);
            
                        },
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
            
                        controller: emailController,
                        validator: (value) {
            
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text);
            
                          if (value == null || value.isEmpty  ) {
                            return 'Please enter email';
                          }
                          if (emailValid ==false ) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: Styles.semi_bold_14,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: AppColors.primary)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.red)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: AppColors.primary)),
                            hintText: 'Your Email',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(

                                  color:   AppColors.primary),),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12))),
                      ),
                      SizedBox(height: 8),
                      Text(
                        " Message",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        focusNode: _focusNode3,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        onFieldSubmitted: (v){
                          FocusScope.of(context).unfocus();
            
                          // if (_formKey.currentState!.validate())  {
                          //   cubit.ContactUS(
                          //     name: nameController.text,
                          //     subject: 'test',
                          //     email: emailController.text,
                          //     message: messageController.text,
                          //   );
                          //
                          // }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter message';
                          }
                          return null;
                        },
                        controller: messageController,
            
                        maxLines: 5,
                        style: Styles.semi_bold_14,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: AppColors.primary)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Colors.red)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: AppColors.primary)),
                            hintText: 'Your Message',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(

                                  color:   AppColors.primary),),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12))),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.primary)
                          ),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Send message logic
            
                            // if (_formKey.currentState!.validate())  {
                            //   cubit.ContactUS(
                            //     name: nameController.text,
                            //     subject: 'test',
                            //     email: emailController.text,
                            //     message: messageController.text,
                            //   );
                            //
                            // }
                          },
                        ),
                      ),
                      SizedBox(height:20),
            
                      SizedBox(height: MediaQuery.sizeOf(context).height / 8),
            
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

}
