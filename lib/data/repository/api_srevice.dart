import 'package:gis_helper/data/resource/transformer_resource.dart';

import '../resource/result_pattern.dart';

abstract class ApiService{
  Future<Result<List<Map<String,dynamic>>>> getAllTransformers();
  Future<Result<List<Map<String,dynamic>>>> getLatestChanges();
  Future<Result<dynamic>> addTransformer(TransformerResource transformer, String path);
}