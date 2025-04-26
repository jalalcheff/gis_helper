import 'package:bloc/bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/search_for_transformers.dart';
import 'package:meta/meta.dart';

import '../../../data/resource/transformer_resource.dart';

part 'search_for_transformer_state.dart';

class SearchForTransformerCubit extends Cubit<SearchForTransformerState> {
  SearchForTransformerCubit(this.searchForTransformersUsecase) : super(SearchForTransformerInitial());
  final SearchForTransformersUsecase searchForTransformersUsecase;
  void emitSearchForTransformers(String query) async {
    emit(SearchForTransformerLoading());
    final result = await searchForTransformersUsecase.searchForTransformers(query);
switch(result) {
  case Ok<List<TransformerResource>>():
    {
      emit(SearchForTransformerLoaded(transformers: result.value));
    }
  case ErrorValue<List<TransformerResource>>():
    emit(SearchForTransformerError(error: result.e.toString()));
}
  }
  void emitSearchForTransformersLoading(){
    emit(SearchForTransformerLoading());
  }
}
