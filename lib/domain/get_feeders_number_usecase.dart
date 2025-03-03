import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/feeders_repository.dart';

class GetFeedersNumberUsecase {
  final FeedersRepository _feedersRepository;

  GetFeedersNumberUsecase({required FeedersRepository feedersRepository}) : _feedersRepository = feedersRepository;

  Future<Result<int>> getAllFeeders() async{
    final Result feeders = await _feedersRepository.getAllFeeders();
    final List<String> tempFeederList = [];
    feeders.forEach((feeder){
      tempFeederList.add(feeder.toString());
      print("feeder inside feeders usecase is : ${feeder}");
    });
    switch(feeders){

    }
    return tempFeederList.length;
  }
}