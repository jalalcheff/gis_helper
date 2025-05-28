import 'package:gis_helper/data/resource/account_resource.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';

abstract class AccountRepository {
  Future<Result<String>>signIn(String email, String password);
}