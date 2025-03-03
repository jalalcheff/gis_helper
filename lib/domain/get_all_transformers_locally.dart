import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

class GetAllTransformersLocallyUsecase {
  final TransformerRepository transformerRepository;

  GetAllTransformersLocallyUsecase({required this.transformerRepository});
  Future<Result<List<TransformerResource>>> getAllTransformers() async{
    final transformers = await transformerRepository.getAllTransformersLocally();
    (transformers as Ok<List<TransformerResource>>).value.forEach((element){
      element.printAllData();
    });
    return transformers;
  }
}
