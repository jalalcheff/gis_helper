import 'package:bloc/bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:meta/meta.dart';

import '../../../data/resource/transformer_resource.dart';
import '../../../domain/delete_transformer_usecase.dart';

part 'delete_transformer_state.dart';

class DeleteTransformerCubit extends Cubit<DeleteTransformerState> {
  DeleteTransformerCubit(this.deleteTransformerUsecase)
      : super(DeleteTransformerInitial());
  final DeleteTransformerUsecase deleteTransformerUsecase;

  Future<void> emitDeleteTransformer(TransformerResource transformerId) async {
    final result = await deleteTransformerUsecase.deleteTransformer(
        transformerId);
    emit(DeleteTransformerLoading());
    switch (result) {
      case Ok<String>():
        {
          emit(DeleteTransformerSuccess(message: "success"));
        }
      case ErrorValue<String>():
        {
          emit(DeleteTransformerError(error: result.e.toString()));
        }
    }
  }
}
