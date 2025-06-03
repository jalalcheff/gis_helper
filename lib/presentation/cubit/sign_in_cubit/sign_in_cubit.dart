import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:meta/meta.dart';

import '../../../domain/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUsecase signInUsecase;
  SignInCubit(this.signInUsecase) : super(SignInInitial());
  void emitSignIn(String email, String password) async{
   // emit(SignInLoading());
    final Result<String> result = await signInUsecase.signIn(email, password);
    print("before delay $result");
    await Future.delayed(const Duration(seconds: 2));
    print("after delay $result");
    switch(result){
      case Ok<String>():
        emit(SignInSuccess(message: result.value));
      case ErrorValue<String>():
        {
          emit(SignInError(message: result.e.toString()));
          print("error in sign in cubit ${result.e}");
        }
    }

  }
  void emitSignInInitial() => emit(SignInInitial());
}
