import 'package:bloc/bloc.dart';
import 'package:gis_helper/domain/update_all_transformers_remotely.dart';
import 'package:meta/meta.dart';

import '../../../data/resource/result_pattern.dart';
import '../../../data/resource/transformer_resource.dart';
import '../../../domain/model/transformer_model.dart';

part 'update_all_transformers_state.dart';

class UpdateAllTransformersCubit extends Cubit<UpdateAllTransformersState> {
  UpdateAllTransformersCubit(this._updateAllTransformersLocallyUsecase) : super(UpdateAllTransformersInitial());
  final UpdateAllTransformersRemotely _updateAllTransformersLocallyUsecase;
  void loadAllTransformers() async{
    final data = await _updateAllTransformersLocallyUsecase.getAllTransformers();
    switch(data){
      case Ok<List<TransformerModel>>():
        {
          print("data updated : ${data.value}");
          emit(UpdateAllTransformersLoaded(transformers: data.value));
        }
      case ErrorValue<List<TransformerModel>>():
        {
          print("data not updated : ${data.e}");
          emit(UpdateAllTransformerError(error: data.e.toString()));
        }
    }
  }
}
