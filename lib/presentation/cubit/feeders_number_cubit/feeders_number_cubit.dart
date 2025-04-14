import 'package:bloc/bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/get_feeders_number_usecase.dart';
import 'package:meta/meta.dart';

import '../../../di/dependency_injection.dart';

part 'feeders_number_state.dart';

class FeedersNumberCubit extends Cubit<FeedersNumberState> {
  FeedersNumberCubit(this._getFeedersNumberUsecase) : super(FeedersNumberInitial());
  final GetFeedersNumberUsecase _getFeedersNumberUsecase;
  void emitFeedersNumber() async {
  final feedersNumber = await _getFeedersNumberUsecase.getAllFeeders();
  switch(feedersNumber) {
    case Ok<int>():
      emit(FeedersNumberLoaded(feedersNumber: feedersNumber.value));
    case ErrorValue<int>():
      emit(FeedersNumberError(error: feedersNumber.e.toString()));
  }
  }
}
