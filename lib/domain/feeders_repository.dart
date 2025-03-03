import 'package:gis_helper/data/resource/result_pattern.dart';

abstract class FeedersRepository {
  Future<Result<dynamic>> getAllFeeders();
}