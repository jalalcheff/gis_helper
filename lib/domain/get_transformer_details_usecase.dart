import '../data/resource/result_pattern.dart';
import '../data/resource/transformer_resource.dart';
import 'transformer_repository.dart';

class GetTransformerDetailsUsecase {
  final TransformerRepository _transformerRepository;

  GetTransformerDetailsUsecase({required TransformerRepository transformerRepository}) : _transformerRepository = transformerRepository;

  Future<Result<TransformerResource>> getTransformerDetails(String transformerSerialNumber) async {
    final transformerResult = await _transformerRepository
        .getAllTransformersLocally();
    switch (transformerResult) {
      case Ok<List<TransformerResource>>():
        {
          final transformer = transformerResult.value.firstWhere((transformer) =>
          transformer.transformerSerialNumber == transformerSerialNumber);
          return Result.ok(transformer);
        }
      case ErrorValue<List<TransformerResource>>():
        return Result.error(transformerResult.e);
    }
  }
}