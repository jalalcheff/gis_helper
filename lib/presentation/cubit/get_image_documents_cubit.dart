import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/domain/model/image_document_model.dart';
import 'package:gis_helper/domain/usecase/get_image_documents_usecase.dart';

part 'get_image_documents_state.dart';

class GetImageDocumentsCubit extends Cubit<GetImageDocumentsState> {
  final GetImageDocumentsUseCase _getImagesUseCase;

  GetImageDocumentsCubit(this._getImagesUseCase) : super(GetImageDocumentsInitial());

  Future<void> getImages() async {
    emit(GetImageDocumentsLoading());
    final result = await _getImagesUseCase.call();
    switch(result) {
      case Ok<List<ImageDocumentModel>>():
        emit(GetImageDocumentsSuccess(result.value));
      case ErrorValue<List<ImageDocumentModel>>():
        {
          emit(GetImageDocumentsError(result.e.toString()));
          print("emmite ${result.e.toString()}");
        }
    }
  }
}