import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

import '../data/resource/transformer_resource.dart';

class DeleteTransformerUsecase {
 final TransformerRepository transformerRepository;

  DeleteTransformerUsecase({required this.transformerRepository});

  Future<Result<String>> deleteTransformer(TransformerResource transformer) async {
    final data = await transformerRepository.deleteTransformer(transformer);
    return data;
  }
}