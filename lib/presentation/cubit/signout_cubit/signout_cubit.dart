import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/resource/result_pattern.dart';
import '../../../domain/signout_usecase.dart';

part 'signout_state.dart';

class SignoutCubit extends Cubit<SignoutState> {
  SignoutCubit(this.signoutUsecase) : super(SignoutInitial());
  final SignoutUsecase signoutUsecase;

  Future<void> emitSignOut() async {
    final result = await signoutUsecase.signOut();
    switch(result){
      case Ok<String>():
        emit(SignoutSuccess(message: result.value));
        break;
      case ErrorValue<String>():
        emit(SignoutError(message: result.e.toString()));
        break;
    }
  }
}
