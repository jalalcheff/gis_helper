import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/model/transformer_model.dart';

abstract class TransformerRepository {
  Future<Result<List<TransformerResource>>> getAllTransformers();

  Future<Result<List<TransformerResource>>> getAllTransformersLocally();

  Future<Result<List<TransformerResource>>> getLastChangesTransformers();
  Future<Result<dynamic>> addTransformerData(TransformerModel transformer, String path);
}
