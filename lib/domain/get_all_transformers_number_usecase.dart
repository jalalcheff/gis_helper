
import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';

class GetAllTransformersNumberUsecase {
  final DatabaseService databaseService;

  GetAllTransformersNumberUsecase({required this.databaseService});

  Future<Result<int>> getAllTransformersNumber() async{
    final transformers = await databaseService.getAllTransformers();
    switch(transformers){

      case Ok<List<TransformerResource>>():
       return Ok(transformers.value.length);
      case ErrorValue<List<TransformerResource>>():
        return ErrorValue("تاكد من الاتصال بالانترنت");
    }
  }
}