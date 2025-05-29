import 'package:bloc/bloc.dart';
import 'package:gis_helper/data/resource/account_resource.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:meta/meta.dart';

import '../../../domain/get_logindata_usecase.dart';

part 'user_accountdata_state.dart';

class UserAccountdataCubit extends Cubit<UserAccountdataState> {
  UserAccountdataCubit(this.getLogindataUsecase) : super(UserAccountdataInitial());
  final GetLogindataUsecase getLogindataUsecase;
  void emitUserAccountdata(AccountResource userAccountdata) async{
    final userDataResult = await getLogindataUsecase.getLogindataUsecase();
    switch(userDataResult) {
      case Ok<AccountResource>():
        emit(UserAccountdataSuccess(userAccountdata: userAccountdata));
      case ErrorValue<AccountResource>():
        emit(UserAccountdataError(message: userDataResult.e.toString()));
    }
  }
}
