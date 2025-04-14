import 'package:bloc/bloc.dart';
import 'package:gis_helper/domain/get_all_transformers_number_usecase.dart';
import 'package:meta/meta.dart';

import '../../../data/resource/result_pattern.dart';

part 'transformer_number_state.dart';

class TransformerNumberCubit extends Cubit<TransformerNumberState> {
  TransformerNumberCubit(this._getTransformerNumberUsecase)
      : super(TransformerNumberInitial());
  final GetAllTransformersNumberUsecase _getTransformerNumberUsecase;

  Future<void> emitTransformerNumber() async {
    final transformerNumber = await _getTransformerNumberUsecase
        .getAllTransformersNumber();
    switch (transformerNumber) {
      case Ok<int>():
        emit(TransformerNumberLoaded(
            transformerNumber: transformerNumber.value));
      case ErrorValue<int>():
        emit(TransformerNumberError(error: transformerNumber.e.toString()));
    }
  }
}
