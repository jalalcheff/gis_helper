
import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

class GetAllTransformersNumberUsecase {
  final DatabaseService databaseService;
  final TransformerRepository transformerRepository;

  GetAllTransformersNumberUsecase({required this.databaseService, required this.transformerRepository});

  Future<Result<int>> getAllTransformersNumber() async{
    final transformers = await databaseService.getAllTransformers();
    switch(transformers){
      case Ok<List<TransformerResource>>():
        {
          return Ok(transformers.value.length);
        }
      case ErrorValue<List<TransformerResource>>():
        {
          final apiTransformers = await transformerRepository.getAllTransformers();
          switch(apiTransformers) {
            case Ok<List<TransformerResource>>():
              return Ok(apiTransformers.value.length);
            case ErrorValue<List<TransformerResource>>():
              return ErrorValue(apiTransformers.e);
          }
        }
    }
  }
}