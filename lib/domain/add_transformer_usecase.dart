import 'package:gis_helper/domain/transformer_repository.dart';

import '../data/resource/result_pattern.dart';
import 'model/transformer_model.dart';

class AddTransformerUsecase {
  final TransformerRepository _transformerRepository;

  AddTransformerUsecase({required TransformerRepository transformerRepository})
      : _transformerRepository = transformerRepository;
  Future<Result<dynamic>> addTransformer(TransformerModel transformer, String path) async {
    final data = await _transformerRepository.addTransformerData(transformer, path);
    return data;
  }
}
