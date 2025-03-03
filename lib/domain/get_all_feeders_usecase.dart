import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/feeders_repository.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

class GetAllFeedersUsecase {
  final FeedersRepository _feedersRepository;

  GetAllFeedersUsecase({required FeedersRepository feedersRepository}) : _feedersRepository = feedersRepository;

  Future<List<String>> getAllFeeders() async{
    final feeders = await _feedersRepository.getAllFeeders();
    final List<String> tempFeederList = [];
    switch(feeders){

      case Ok():
        // TODO: Handle this case.
      case ErrorValue():
        // TODO: Handle this case.
    }
    feeders.forEach((feeder){
      tempFeederList.add(feeder.toString());
      print("feeder inside feeders usecase is : ${feeder}");
    });
    return tempFeederList;
  }
}