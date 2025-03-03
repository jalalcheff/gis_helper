import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';

abstract class TransformerRepository {
  Future<Result<List<TransformerResource>>> getAllTransformers();

  Future<Result<List<TransformerResource>>> getAllTransformersLocally();

  Future<Result<List<TransformerResource>>> getLastChangesTransformers();
}
