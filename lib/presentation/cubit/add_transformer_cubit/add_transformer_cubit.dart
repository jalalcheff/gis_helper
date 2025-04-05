import 'package:bloc/bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/model/transformer_model.dart';
import 'package:meta/meta.dart';

import '../../../data/database_service/database_service_imp.dart';
import '../../../data/service/api_service_imp.dart';
import '../../../domain/add_transformer_usecase.dart';

part 'add_transformer_state.dart';

class AddTransformerCubit extends Cubit<AddTransformerState> {
  final AddTransformerUsecase _addTransformerUsecase;
  AddTransformerCubit(this._addTransformerUsecase) : super(AddTransformerInitial());
  Future<void> addTransformer(TransformerModel transformer , String path) async {
    emit(AddTransformerLoading());
    final data = await _addTransformerUsecase.addTransformer(transformer, path);
    switch(data) {
      case Ok():
        emit(AddTransformerLoaded("loaded"));
      case ErrorValue():
        emit(AddTransformerError("error"));
    }
  }
  emitLoadingState(){
    emit(AddTransformerLoading());
  }
}
