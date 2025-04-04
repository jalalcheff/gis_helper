import 'package:bloc/bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/model/transformer_model.dart';
import 'package:meta/meta.dart';

import '../../../data/resource/transformer_resource.dart';
import '../../../domain/get_all_transformers_locally.dart';

part 'all_transformers_state.dart';

class AllTransformersCubit extends Cubit<AllTransformersState> {
  final GetAllTransformersLocallyUsecase _getAllTransformersLocallyUsecase;
  AllTransformersCubit(this._getAllTransformersLocallyUsecase) : super(AllTransformersInitial());
  void loadAllTransformers(List<TransformerResource> transformers) async{
    final data = await _getAllTransformersLocallyUsecase.getAllTransformers();
    switch(data){

      case Ok<List<TransformerModel>>():
        emit(AllTransformersLoaded(transformers: data.value));
      case ErrorValue<List<TransformerModel>>():
        emit(AllTransformersError(error: data.e.toString()));
    }
  }
}
