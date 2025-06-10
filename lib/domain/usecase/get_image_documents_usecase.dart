import '../model/image_document_model.dart';
import '../repository/image_document_repository.dart';
import '../../data/resource/result_pattern.dart';

class GetImageDocumentsUseCase {
  final ImageDocumentRepository _repository;

  GetImageDocumentsUseCase(this._repository);

  Future<Result<List<ImageDocumentModel>>> call() async {
    final result = await _repository.getImages();
    switch (result) {
      case Ok<List<ImageDocumentModel>>():
        {
          print("emmite usecase ${result.value}");
        }
      case ErrorValue<List<ImageDocumentModel>>():
        print("emmite usecase error ${result.e.toString()}");
    }
    return _repository.getImages();
  }
}