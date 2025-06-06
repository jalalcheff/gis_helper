import '../../domain/model/image_document_model.dart';
import '../../domain/repository/image_document_repository.dart';
import '../service/image_document_service.dart';

class ImageDocumentRepositoryImp implements ImageDocumentRepository {
  final ImageDocumentService _imageDocumentService;

  ImageDocumentRepositoryImp(this._imageDocumentService);

  @override
  Future<void> addImageDocument(ImageDocumentModel imageDocument) async {
    try {
      await _imageDocumentService.addImageDocument(imageDocument);
    } catch (e) {
      throw Exception('Failed to add image document to repository: $e');
    }
  }
}