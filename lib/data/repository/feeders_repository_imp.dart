import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/feeders_repository.dart';

class FeedersRepositoryImp implements FeedersRepository{
  final DatabaseService localDatabaseTransformers;

  FeedersRepositoryImp({required this.localDatabaseTransformers});
  @override
  Future<Result<List<String>>> getAllFeeders() async{
    final Result<List<TransformerResource>> transformers = await localDatabaseTransformers.getAllTransformers();
    final Set<String> feeders = {};
    final Result<List<String>> finalResult;
    switch(transformers) {
      case Ok<List<TransformerResource>>():
        {
          for (var transformer in transformers.value) {
            feeders.add(transformer.feederName);
          }
          finalResult = Ok(feeders.toList());
        }
      case ErrorValue<List<TransformerResource>>():
        finalResult = ErrorValue(transformers.e);
    }
    return finalResult;
  }
}