import 'package:gis_helper/data/repository/api_srevice.dart';
import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/data/service/api_service_imp.dart';
import 'package:gis_helper/domain/feeders_repository.dart';

class FeedersRepositoryImp implements FeedersRepository{
  final DatabaseService localDatabaseTransformers;
  final ApiService apiService;

  FeedersRepositoryImp( {required this.localDatabaseTransformers, required this.apiService});
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
        {
          final apiFeeders = await apiService.getAllTransformers();
          switch(apiFeeders) {
            case Ok<List<Map<String, dynamic>>>():
              {
                _convertToFeeders(apiFeeders.value);
                final feeders = _convertToFeeders(apiFeeders.value);
                return Ok(feeders.toList());
              }
            case ErrorValue<List<Map<String, dynamic>>>():
              return ErrorValue(apiFeeders.e);
          }
        }
    }
    return finalResult;
  }

  Set<String> _convertToFeeders(List<Map<String, dynamic>> value) {
    final Set<String> feeders = {};
    for (var transformer in value) {
      feeders.add(transformer['feederName']);
    }
    return feeders;
  }
}