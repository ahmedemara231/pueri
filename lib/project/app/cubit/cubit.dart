import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pueri_project/project/app/cubit/state.dart';
import 'package:pueri_project/project/presentation/UI/admain/booking_model.dart';
import 'package:pueri_project/project/presentation/resourses/network/local/casheHelper.dart';
import '../../presentation/UI/doctor/doctor.dart';
import '../../presentation/UI/home/home.dart';
import '../../presentation/UI/login/login_screen.dart';
import '../../presentation/UI/message/message.dart';
import '../../presentation/UI/profile/profile.dart';
import '../../presentation/UI/watch/watch.dart';
import '../../presentation/resourses/constants/app_constants.dart';
import '../../presentation/resourses/models/hospital_model/hospital_model.dart';
import '../../presentation/resourses/models/user/user_model.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppIniteal());

  static AppCubit get(context) => BlocProvider.of(context);
  int bottomNavIndex = 0;
  List<Widget> App_Screens = [
    HomeScreen(),
    Doctor_Screen(),
    Message_Screen(),
    Profile_Screen()
  ];


  String place_filter = 'Kafr ElSheikh';

  void ChangeBottomBarIndex(index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavBarState());
  }


  void ChangeLocation(place) {
    place_filter = place;
    finalList = topRated.where((element) => element.location == place_filter).toList();
    finalListFiltering = List.from(finalList);
    emit(changeLocationState());
  }

  Future<void> signUpAndStoreUserData({
    required String email,
    required String password,
    required String first_name,
    required String last_name,
    required context,
  }) async {
    emit(SignUpLodingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );

      String uid = userCredential.user!.uid;
      print(uid);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login_screen(),), (route) => false);

     await FirebaseFirestore.instance.collection('users').doc(uid).set(
          {
            'last_name': last_name,
            'first_name': first_name,
            'phone': '',
            'date_birth': '',
            'favorites': [],
            'email': email,
            'password': password,
            'id': uid,
          },
      ).then((value)
      {
        emit(GetUserDataLodingState());

        // late User_Model registeredUser;
        // getUserData(FirebaseAuth.instance.currentUser?.uid);
        emit(SignUpSucssesState());
      });
      print('User signed up and data stored successfully');
    } catch (e) {
      emit(SignUpErrorState());
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // Show a Snackbar when the email is already in use

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'email-already-in-use',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else if (e.code == 'too-many-requests') {
          // Show a Snackbar when the password is incorrect

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'too-many-request',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else if (e.code == 'weak-password') {
          // Show a Snackbar when the password is too weak
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'weak-password',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else {
          // Handle other FirebaseAuth errors
          print('FirebaseAuth error during user sign-up: ${e.message}');
        }
      } else if (e is FirebaseException && e.code == 'network-request-failed') {
        // Show a Snackbar for network/connection error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                textAlign: TextAlign.center,
                '5eu08qdd',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white)),
            duration: Duration(seconds: 3), // Adjust the duration as needed
          ),
        );
      } else {
        // Handle other errors
        print('Error during user sign-up: $e');
      }
      throw e;
    }
  }

  Future<void> signIN({
    required String email,
    required String password,
    required context,
  }) async {
    emit(SignINLodingState());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value)async {
            await FirebaseFirestore.instance.collection('users').doc(value.user?.uid)
            .get()
            .then((value)
            {
              CacheHelper.sharedPreferences.setStringList(
                'userData',
                [
                  value.id,
                  value.data()?['first_name'],
                  value.data()?['last_name'],
                  value.data()?['email'],
                ],
              );
            });


        print(CacheHelper.sharedPreferences.getStringList('userData')?[0]);
        emit(GetUserDataLodingState());
        getUserData(value.user?.uid);
        emit(SignINSucssesState());
      });

      print('User signed up and data stored successfully');
    } catch (e) {
      emit(SignINErrorState());
      if (e is FirebaseAuthException) {
        print(e.code);
        if (e.code == 'user-not-found') {
          // Show a Snackbar when email is not found
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'المستخدم غير موجود',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else if (e.code == 'wrong-password') {
          // Show a Snackbar when the password is incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'الباسورد خطا',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else if (e.code == 'too-many-requests') {
          // Show a Snackbar when the password is incorrect
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  textAlign: TextAlign.center,
                  'عدد معاملات كثيره يرجا الانتظار قليلا',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white)),
              duration: Duration(seconds: 3), // Adjust the duration as needed
            ),
          );
        } else {
          // Handle other FirebaseAuth errors
          print('FirebaseAuth error during user sign-in: ${e.message}');
        }
      } else if (e is FirebaseException && e.code == 'network-request-failed') {
        // Show a Snackbar for network/connection error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                textAlign: TextAlign.center,
                'يرجا مراجعه الاتصال الخاص بك',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white)),
            duration: Duration(seconds: 3), // Adjust the duration as needed
          ),
        );
      } else {
        // Handle other errors
        print('Error during user sign-in: $e');
      }
    }
  }

  void SignOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      print(FirebaseAuth.instance.currentUser);
      AppConstants.navigateToAndFinish(context, Login_screen());
      emit(SignOutSucssesState());
    }).catchError((error) {
      emit(SignOutErrorState());
    });
  }

  User_Model? user_model;

  Future<void> getUserData(uid)async {
    print(FirebaseAuth.instance.currentUser?.uid);
    emit(GetUserDataLodingState());
    await FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      print(value.data());
      user_model = User_Model.fromJson(value.data()!);
      print(user_model?.first_name);
      emit(GetUserDataSucssesState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  void UpdateUser(User_Model updated_model) async {
    emit(UpdateLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(updated_model.toJson())
        .then((value) {
      emit(UpdateSucssesState());
      getUserData(FirebaseAuth.instance.currentUser?.uid);
    }).catchError((e) {
      print(e.toString());
      emit(UpdateErrorState());
    });
  }

  void Upload_Hospital(Hospital_Model hospital_model) async {
    emit(Upload_Hos_LoadingState());
    FirebaseFirestore.instance
        .collection('Hospitals')
        .add(hospital_model.toJson())
        .then((value) {
      print(value.id);
      FirebaseFirestore.instance.collection('Hospitals').doc(value.id).update({
        'id': value.id,
      });
      emit(Upload_Hos_SucssesState());
      Get_Hospital();
    }).catchError((e) {
      print(e.toString());
      emit(Upload_Hos_ErrorState());
    });
  }


  List<Hospital_Model> topratedList = [];
  List<Hospital_Model> searchOnTopRatedBasedOnLocation = [];

  // void initSearchListBasedOnLocation()
  // {
  //   searchOnTopRatedBasedOnLocation = [];
  //
  //   topRated.forEach((element) {
  //     log('location : ${element.location}');
  //
  //     if(element.location == place_filter)
  //       {
  //         searchOnTopRatedBasedOnLocation.add(element);
  //       }
  //   });
  //   log('help$searchOnTopRatedBasedOnLocation');
  //
  //   emit(InitSearchListBasedOnLocation());
  // }

  // void search(String pattern)
  // {
  //   if(pattern.isEmpty)
  //     {
  //       topratedList = List.from(topRated);
  //       print(topratedList);
  //       emit(state);
  //     }
  //   else{
  //     topratedList = searchOnTopRatedBasedOnLocation.where((element) => element.hospital_name!.contains(pattern)).toList();
  //     print(topratedList);
  //     emit(state);
  //   }
  // }



  List<Hospital_Model> hospitals = [];
  List<Hospital_Model> topRated = [];
  List<Hospital_Model> favorite_list = [];

  List<Hospital_Model> finalList = [];
  List<Hospital_Model> finalListFiltering = [];

  Future<void> Get_Hospital() async {
    hospitals = [];
    topRated = [];
    favorite_list = [];

    emit(get_Hos_LoadingState());
    await FirebaseFirestore.instance.collection('hospitals').get().then((value) {
      value.docs.forEach((element) async{

        if(element.data()['location'] == 'Kafr ElSheikh')
          {
            print('Kafr ElSheikh');
          }
        hospitals.add(Hospital_Model.fromJson(element.data(),element.id));

        if (element.data()['topRated']) {
          topRated.add(Hospital_Model.fromJson(element.data(),element.id));
        }

        if (user_model!.favorites!.contains(element.id)) {
          favorite_list.add(Hospital_Model.fromJson(element.data(),element.id));
        }
      });

      topratedList = List.from(topRated);

      finalList = topRated.where((element) => element.location == place_filter).toList();
      finalListFiltering = List.from(finalList);

      emit(get_Hos_SucssesState());

      // initSearchListBasedOnLocation();

    }).catchError((e) {
      print(e.toString());
      emit(get_Hos_ErrorState());
    });
  }

  void search(String pattern)
  {
    if(pattern.isEmpty)
    {
      finalListFiltering = List.from(finalList);
      emit(state);
    }
    else{
      finalListFiltering = finalList.where((element) => element.hospital_name!.contains(pattern)).toList();
      emit(state);
    }
  }


  // List<Hospital_Model> topRatedList2 = [];
  // void filterLocations()
  // {
  //   topRatedList2 =  topRated.where((element) => element.location == place_filter).toList();
  //   emit(MakeTopRatedBasedOnLocation());
  // }


  Future<void> bookDateWithDoctor({
    required String name,
    required String day,
    required String time,
})async
  {
    emit(BookDateWithDoctorLoading());

    await FirebaseFirestore.instance
        .collection('doctorsDates')
        .add(
        {
          'userId' : CacheHelper.sharedPreferences.getStringList('userData')![0],
          'userName' : CacheHelper.sharedPreferences.getStringList('userData')![1] + '  ' + CacheHelper.sharedPreferences.getStringList('userData')![2],
          'userEmail' : CacheHelper.sharedPreferences.getStringList('userData')![3],
          'doctorName' : name,
          'day' : day,
          'time' : time,
        },
    ).then((value)
    {
      log('Done');
      emit(BookDateWithDoctorSuccess());
    }).catchError((error)
    {
      emit(BookDateWithDoctorError());
    });
  }

  // Future<void> getDoctorsDates(String doctorName)async
  // {
  //   log(doctorName);
  //   emit(GetDoctorsDatesLoading());
  //   await FirebaseFirestore.instance
  //       .collection('doctorsDates')
  //       .where('doctorName',isEqualTo: doctorName)
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //
  //     });
  //     log('$bookedDates');
  //     emit(GetDoctorsDatesSuccess());
  //   }).catchError((error){
  //     emit(GetDoctorsDatesError());
  //   });
  // }

  List<bool> isTimeAvaliable = [];
  List<String> bookedDates = [];
  Future<void> showBookedDatesForSpecificDay({
    required String name,
    required String day,
    required List<String> timeList
})async
  {
    emit(GetDoctorsDatesLoading());
    bookedDates = [];
    isTimeAvaliable = [];
    await FirebaseFirestore.instance
        .collection('doctorsDates')
        .where('doctorName',isEqualTo: name)
        .where('day',isEqualTo: day)
        .get()
        .then((value)
    {
      value.docs.forEach((element) {
        bookedDates.add(element.data()['time']);
      });
      log('$bookedDates');

      if(bookedDates.isEmpty)
        {
          timeList.forEach((element) {
            isTimeAvaliable.add(true);
          });
        }
      else{

        for(String time in timeList)
          {
            if(bookedDates.contains(time))
              {
                isTimeAvaliable.add(false);
              }
            else{
              isTimeAvaliable.add(true);
            }
          }
      }


      log('the bool list is $isTimeAvaliable');

      emit(GetDoctorsDatesSuccess());
    });
  }


  List<DoctorBook> doctorsBooking = [];
  Future<void> getAllDoctorsBooks()async
  {
    emit(GetAllDoctorsBookingLoading());
    doctorsBooking = [];
    await FirebaseFirestore.instance
        .collection('doctorsDates')
        .get()
        .then((value)
    {
      value.docs.forEach((element) {
        doctorsBooking.add(
            DoctorBook(
              doctorName: element.data()['doctorName'],
              uId: element.data()['userId'],
              day: element.data()['day'],
              time: element.data()['time'],
              userName: element.data()['userName'],
              bookId: element.id,
            ),
        );
      });
      emit(GetAllDoctorsBookingSuccess());
      print(doctorsBooking.length);
    }).catchError((error){
      emit(GetAllDoctorsBookingError());
    });
  }

  Future<void> deleteDoctorBooking(int index)async
  {
    await FirebaseFirestore.instance
        .collection('doctorsDates')
        .doc(doctorsBooking[index].bookId)
        .delete().then((value) {
      log('Done');
      doctorsBooking.removeWhere((element) => element.bookId == doctorsBooking[index].bookId);
      emit(DeleteDoctorBookingSuccess());
    });
  }

  void make_favorite(id) {
    emit(makeFavoriteLoadingState());
    var userId =FirebaseAuth.instance.currentUser!.uid;
   var  favorites = user_model?.favorites??[];
    if (!favorites.contains(id)) {
      favorites.add(id);
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({
      'favorites':favorites
    })
        .then((value) {
          getUserData(userId);
          Get_Hospital();
      emit(makeFavoriteSucssesState());

    })
        .catchError((e) {
          print(e.toString());
          emit(makeFavoriteErrorState());
    });

  }
  void remove_favorite(hosid) {
    emit(remove_FavoriteLoadingState());
   var  favorites = user_model?.favorites??[];
    var userId =FirebaseAuth.instance.currentUser!.uid;

    if (favorites.contains(hosid)) {
      favorites.removeWhere((id) => id == hosid);
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'favorites':favorites
    })
        .then((value) {
      getUserData(userId);
      Get_Hospital();
      emit(remove_FavoriteSucssesState());

    })
        .catchError((e) {
          print(e.toString());
          emit(remove_FavoriteErrorState());
    });
  }
}
