import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

import 'account_repository.dart';

class SignInUsecase {
  final AccountRepository _accountRepository;

  SignInUsecase({required AccountRepository accountRepository}) : _accountRepository = accountRepository;

  Future<Result<String>> signIn(String email, String password) async{
    final result = await _accountRepository.signIn(email, password);
    return result;
  }
}