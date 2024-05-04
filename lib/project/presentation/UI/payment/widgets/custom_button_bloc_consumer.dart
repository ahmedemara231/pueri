
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/cubit/cubit.dart';
import '../../../../app/cubit/state.dart';
import 'customButton.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return customButton(
          title: 'Continue',
          onTap: () {

          },
          isLoading:  false,
        );
      },
    );
  }
}
