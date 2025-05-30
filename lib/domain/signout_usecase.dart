import 'package:gis_helper/domain/account_repository.dart';

import '../data/resource/result_pattern.dart';

class SignoutUsecase {
  final AccountRepository accountRepository;

  SignoutUsecase({required this.accountRepository});

  Future<Result<String>> signOut() async {
    final result = await accountRepository.clearSharedPrefs();
    return result;
  }
}