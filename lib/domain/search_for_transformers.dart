import 'package:gis_helper/data/repository/transformer_repository_imp.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';

class SearchForTransformersUsecase {
  final TransformerRepositoryImp transformerRepository;

  SearchForTransformersUsecase({required this.transformerRepository});

  Future<Result<List<TransformerResource>>> searchForTransformers(
      String query) async {
    final transformers = await transformerRepository.getAllTransformers();
    final Result<List<TransformerResource>> filteredTransformers;
    switch (transformers) {
      case Ok<List<TransformerResource>>():
        {
          filteredTransformers =
              Result.ok(transformers.value.where((transformer) {
            return searchForAllData(query, transformer);
          }).toList());
          print("inside SearchForTransformersUsecase ok list are : ${(filteredTransformers as Ok<List<TransformerResource>>).value[0].feederName}");
          return filteredTransformers;
        }
      case ErrorValue<List<TransformerResource>>():
        {
          return ErrorValue(transformers.e);
        }
    }
  }

  bool searchForAllData(String query, TransformerResource transformer) {
    return transformer.feederName.contains(query) ||
        transformer.mahlaOrSector.contains(query) ||
        transformer.transformerName.contains(query) ||
        transformer.substationName.contains(query) ||
        transformer.transformerCapacity.contains(query) ||
        transformer.transformerSerialNumber.contains(query) ||
        transformer.yCoordinates.contains(query) ||
        transformer.yCoordinates.contains(query) ||
        transformer.isItPrivate.toString().contains(query) ||
        transformer.isItOverhead.toString().contains(query);
  }
}
