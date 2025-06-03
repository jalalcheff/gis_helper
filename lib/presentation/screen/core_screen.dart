import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/presentation/cubit/user_accountdata_cubit/user_accountdata_cubit.dart';
import 'package:gis_helper/presentation/screen/sign_in_screen/sign_in_screen.dart';
import 'package:lottie/lottie.dart';

import '../../constants/style_constants.dart';
import 'main_screen/collection_screen.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({super.key});

  @override
  State<CoreScreen> createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  late StyleConstants styleConstants;

  @override
  void initState() {
    context.read<UserAccountdataCubit>().emitUserAccountdata();
    styleConstants = StyleConstants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAccountdataCubit, UserAccountdataState>(
      builder: (context, state) {
        switch(state) {
          case UserAccountdataInitial():
            {
              return SignInScreen();
            }
          case UserAccountdataSuccess():
            {
              return CollectionScreen();
            }
          case UserAccountdataError():
            {
              return SignInScreen();
            }
        }
      },
    );
  }
}
