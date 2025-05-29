import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/account_repository.dart';

import '../data/resource/account_resource.dart';

class GetLogindataUsecase {
  final AccountRepository accountRepository;

  GetLogindataUsecase({required this.accountRepository});
  Future<Result<AccountResource>> getLogindataUsecase() async{
    final loginData = await accountRepository.SharedPrefsLoginData();
    return loginData;
  }
}