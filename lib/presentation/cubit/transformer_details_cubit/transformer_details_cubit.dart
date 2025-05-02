import 'package:bloc/bloc.dart';
import 'package:gis_helper/domain/get_transformer_details_usecase.dart';
import 'package:meta/meta.dart';

import '../../../data/resource/result_pattern.dart';
import '../../../data/resource/transformer_resource.dart';

part 'transformer_details_state.dart';

class TransformerDetailsCubit extends Cubit<TransformerDetailsState> {
  TransformerDetailsCubit(this.getTransformerDetailsUsecase) : super(TransformerDetailsInitial());
  final GetTransformerDetailsUsecase getTransformerDetailsUsecase;
  void emitTransformerDetailsLoading(){
    emit(TransformerDetailsLoading());
  }
  void emitTransformerDetailsLoaded(String transformerSerialNumber) async{
    final Result<TransformerResource> result = await getTransformerDetailsUsecase.getTransformerDetails(transformerSerialNumber);
    switch(result) {
      case Ok<TransformerResource>():
    emit(TransformerDetailsLoaded(transformer: result.value));
      case ErrorValue<TransformerResource>():
        emit(TransformerDetailsError(error: result.e.toString()));
    }
  }
  void emitTransformerDetailsError(String error) {
    emit(TransformerDetailsError(error: error));
  }
}
