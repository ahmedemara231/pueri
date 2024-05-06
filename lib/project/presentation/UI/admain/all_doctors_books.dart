import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pueri_project/project/app/cubit/cubit.dart';
import 'package:pueri_project/project/app/cubit/state.dart';
import 'package:pueri_project/project/presentation/resourses/styles/colors.dart';

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
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cubit.doctorsBooking[index].doctorName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                      const Text('Day / Time :',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      Row(
                        children: [
                          Text('${cubit.doctorsBooking[index].day} / ${cubit.doctorsBooking[index].time}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                          const Spacer(),
                          IconButton(
                              onPressed: () async
                              {
                                await cubit.deleteDoctorBooking(index);
                              },
                              icon: const Icon(Icons.delete,color: Colors.red,))
                        ],
                      ),
                      Text('user Name : ${cubit.doctorsBooking[index].userName}'),
                    ],
                  ),
                ),
              ),
            ),
            separatorBuilder:(context, index) => const SizedBox(height: 16,),
            itemCount: cubit.doctorsBooking.length
        ),
      ),
    );
  }
}
/*
* Card(
              child: ListTile(
                title: Text(
                  cubit.doctorsBooking[index].doctorName,
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                ),
                trailing: IconButton(
                    onPressed: () async
                    {

                    },
                    icon: const Icon(Icons.delete,color: Colors.red),
                ),
              )
            ),*/