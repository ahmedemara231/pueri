import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pueri_project/project/app/cubit/cubit.dart';
import 'package:pueri_project/project/app/cubit/state.dart';

class DoctorsBooks extends StatefulWidget {
  const DoctorsBooks({super.key});

  @override
  State<DoctorsBooks> createState() => _DoctorsBooksState();
}


class _DoctorsBooksState extends State<DoctorsBooks> {

  late AppCubit cubit;
  @override
  void initState() {
    cubit = AppCubit.get(context);
    cubit.getAllDoctorsBooks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
      ),
      body: BlocBuilder<AppCubit,AppState>(
        builder: (context, state) => state is GetAllDoctorsBookingLoading?
        const Center(
        child: CircularProgressIndicator(),
      ):
        ListView.separated(
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(
                  cubit.doctorsBooking[index].doctorName,
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                ),
                trailing: IconButton(
                    onPressed: () async
                    {
                      await cubit.deleteDoctorBooking(index);
                    },
                    icon: const Icon(Icons.delete,color: Colors.red),
                ),
              )
            ),
            separatorBuilder:(context, index) => const SizedBox(height: 16,),
            itemCount: cubit.doctorsBooking.length
        ),
      ),
    );
  }
}
