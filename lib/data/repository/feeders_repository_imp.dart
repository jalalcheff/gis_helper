import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/feeders_repository.dart';

class FeedersRepositoryImp implements FeedersRepository{
  final DatabaseService localDatabaseTransformers;

  FeedersRepositoryImp({required this.localDatabaseTransformers});
  @override
  Future<Result<dynamic>> getAllFeeders() async{
    final transformers = await localDatabaseTransformers.getAllTransformers();
    final Set feeders = {};
    final Result finalResult;
    switch(transformers){

      case Ok<List<TransformerResource>>():
        {
          (transformers as Ok<List<TransformerResource>>)
              .value
              .forEach((transformer) {
            feeders.add(transformer.feederName);
          });
          finalResult = Ok(feeders.toList());
        }
      case ErrorValue<List<TransformerResource>>():{
        finalResult = ErrorValue(" تاكد من الاتصال بالانترنت لا يوجد بيانات");
      }

    }

    return finalResult;
  }
}