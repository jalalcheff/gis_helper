import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';

abstract class DatabaseService {
  Future<Result<List<TransformerResource>>> getAllTransformers();
  saveDataIntoDatabase(List<TransformerResource> transform);
//  Future<Result<List<TransformerResource>>> getAllTransformers();
  Future<Result<List<TransformerResource>>> getLatestTransformers();
  Future<String> saveLatestTransformersDataIntoDatabase(List<TransformerResource> transformer);
}
