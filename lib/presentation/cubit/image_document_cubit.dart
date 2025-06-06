import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/model/image_document_model.dart';
import '../../domain/usecase/add_image_document_usecase.dart';

part 'image_document_state.dart';

class ImageDocumentCubit extends Cubit<ImageDocumentState> {
  final AddImageDocumentUseCase addImageDocumentUseCase;

  ImageDocumentCubit({required this.addImageDocumentUseCase}) : super(ImageDocumentInitial());

  Future<void> addImageDocument(ImageDocumentModel imageDocument) async {
    try {
      emit(ImageDocumentLoading());
      await addImageDocumentUseCase(imageDocument);
      emit(ImageDocumentSuccess());
    } catch (e) {
      emit(ImageDocumentFailure(e.toString()));
    }
  }
}