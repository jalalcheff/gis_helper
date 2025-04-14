import 'package:bloc/bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/model/transformer_model.dart';
import 'package:meta/meta.dart';

import '../../../domain/get_latest_changes_usecase.dart';

part 'latest_changes_state.dart';

class LatestChangesCubit extends Cubit<LatestChangesState> {
  final GetLatestChangesUsecase getLatestChangesUsecase;
  LatestChangesCubit(this.getLatestChangesUsecase) : super(LatestChangesInitial());
  Future<void> loadLatestChanges() async {
    Result<List<TransformerModel>> result = await getLatestChangesUsecase.getLatestChanges();
    switch(result) {
      case Ok<List<TransformerModel>>():
        emit(LatestChangesLoaded(latestTransformers: result.value));
      case ErrorValue<List<TransformerModel>>():
        emit(LatestChangesError(error: result.e.toString()));
    }
    }
  }
