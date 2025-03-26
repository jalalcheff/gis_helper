import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/feeders_repository.dart';
import 'package:gis_helper/domain/model/transformer_model.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

class GetAllFeedersUsecase {
  final FeedersRepository _feedersRepository;

  GetAllFeedersUsecase({required FeedersRepository feedersRepository}) : _feedersRepository = feedersRepository;

  Future<List<String>> getAllFeeders() async{
    final feeders = await _feedersRepository.getAllFeeders();
    final List<String> tempFeederList = [];
    int counter = 0;
    final Result<List<String>> finalResult;
    switch(feeders){
      case Ok():
        {
          (feeders as Ok<List<TransformerResource>>).value.forEach((feeder) {
            tempFeederList.add(TransformerModel.fromTransformerResource(feeder).feederName);
            print("feeder inside feeders usecase is : ${feeder}");
          });
          finalResult = Ok(tempFeederList);
          (finalResult as Ok<List<String>>).value.forEach((feeder){
            print("all feeder usecase $feeder");
          });
        }
      case ErrorValue():
        {
          finalResult = ErrorValue(feeders.e);
          print("error all feeder ${feeders.e}");
        }
    }
    return tempFeederList;
  }
}