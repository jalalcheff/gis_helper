import 'package:gis_helper/constants/general_constants.dart';
import 'package:gis_helper/data/repository/transformer_repository_imp.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';

class SearchForTransformersUsecase {
  final TransformerRepositoryImp transformerRepository;

  SearchForTransformersUsecase({required this.transformerRepository});

  Future<Result<List<TransformerResource>>> searchForTransformers(String query,
      int sortAccordingToCapacity, int sortAccordingToType) async {
    final transformers = await transformerRepository.getAllTransformers();
    final List<TransformerResource> filteredTransformers;
    switch (transformers) {
      case Ok<List<TransformerResource>>():
        {
          if (query.isEmpty) {
            filteredTransformers = transformers.value;
          }
          else{
            filteredTransformers = transformers.value.where((transformer) {
              return searchForAllData(query, transformer);
            }).toList();
          }
          if (sortAccordingToCapacity ==
              GeneralConstants.SEARCH_FILTER_LOWER_TO_HIGHER) {
            filteredTransformers.sort((a, b) =>
                a.transformerCapacity.compareTo(b.transformerCapacity));
          } else {
            filteredTransformers.sort((a, b) =>
                b.transformerCapacity.compareTo(a.transformerCapacity));
          }
          switch (sortAccordingToType) {
            case GeneralConstants.SEARCH_FILTER_OVERHEAD_TRANSFORMER:
              {
                filteredTransformers
                    .removeWhere((element) => !element.isItOverhead);
                break;
              }
            case GeneralConstants.SEARCH_FILTER_KISOK_TRANSFORMER:
              {
                filteredTransformers
                    .removeWhere((element) => element.isItOverhead);
                break;
              }
            case GeneralConstants.SEARCH_FILTER_GOVERN_TRANSFORMER:
              {
                filteredTransformers
                    .removeWhere((element) => !element.isItPrivate);
                break;
              }
            case GeneralConstants.SEARCH_FILTER_PRIVATE_TRANSFORMER:
              {
                filteredTransformers
                    .removeWhere((element) => element.isItPrivate);
                break;
              }
            default:
              {
                break;
              }
          }
          print(
              "inside SearchForTransformersUsecase ok list are : ${filteredTransformers.length}");
          return Result.ok(filteredTransformers);
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
        transformer.isItOverhead.toString().contains(query) ||
        transformer.zuqaqOrBlock.contains(query);
  }
}
