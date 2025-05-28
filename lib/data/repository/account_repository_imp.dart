import 'package:gis_helper/data/repository/api_srevice.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';

import '../../domain/account_repository.dart';

class AccountRepositoryImp implements AccountRepository{
  final ApiService apiService;

  AccountRepositoryImp({required this.apiService});
  @override
  Future<Result<String>> signIn(String email, String password) {
    final result = apiService.signIn(email, password);
    return result;
  }
}