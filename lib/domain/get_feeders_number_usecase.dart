import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/feeders_repository.dart';

class GetFeedersNumberUsecase {
  final FeedersRepository _feedersRepository;

  GetFeedersNumberUsecase({required FeedersRepository feedersRepository}) : _feedersRepository = feedersRepository;

  Future<Result<int>> getAllFeeders() async{
    final Result feeders = await _feedersRepository.getAllFeeders();
    final List<String> tempFeederList = [];
    final Result<int> finalResult;
    switch(feeders){

      case Ok():
        {
          (feeders as Ok<List<TransformerResource>>).value.forEach((feeder){
            tempFeederList.add(feeder.toString());
            print("feeder inside feeders usecase is : ${feeder}");
          });
          finalResult = Ok(tempFeederList.length);
        }
      case ErrorValue():
        {
          finalResult = ErrorValue(feeders.e);
        }
    }
    return finalResult;
  }
}