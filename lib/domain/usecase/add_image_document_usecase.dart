import '../model/image_document_model.dart';
import '../repository/image_document_repository.dart';

class AddImageDocumentUseCase {
  final ImageDocumentRepository _repository;

  AddImageDocumentUseCase(this._repository);

  Future<void> call(ImageDocumentModel imageDocument) async {
    await _repository.addImageDocument(imageDocument);
  }
}