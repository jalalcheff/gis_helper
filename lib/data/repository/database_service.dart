import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';

abstract class DatabaseService {
  Future<Result<List<TransformerResource>>> getAllTransformers();
  Future<Result<List<TransformerResource>>> saveDataIntoDatabase(Result<List<Map<String,dynamic>>> transform);
//  Future<Result<List<TransformerResource>>> getAllTransformers();
  Future<Result<List<TransformerResource>>> getLatestTransformers();
  Future<Result<List<TransformerResource>>> saveLatestTransformersDataIntoDatabase(Result<List<Map<String,dynamic>>> transformer);
}
