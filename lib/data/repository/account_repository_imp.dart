import 'package:gis_helper/data/repository/api_srevice.dart';
import 'package:gis_helper/data/resource/account_resource.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';

import '../../domain/account_repository.dart';
import '../database_service/shared_prefs.dart';

class AccountRepositoryImp implements AccountRepository{
  final ApiService apiService;

  AccountRepositoryImp({required this.apiService});
  @override
  Future<Result<String>> signIn(String email, String password) {
    final result = apiService.signIn(email, password);
    return result;
  }

  @override
  Future<Result<AccountResource>> SharedPrefsLoginData() async{
    final loginData = await SharedPrefs().readDataFromSharedPrefs();
    switch(loginData) {
      case Ok<Map<String, dynamic>>():
        {
          final finalResult = AccountResource.fromJson(loginData.value);
          return Result.ok(finalResult);
        }
      case ErrorValue<Map<String, dynamic>>():
        return Result.error(loginData.e);
    }
  }
}