import '../../domain/model/image_document_model.dart';

abstract class ImageDocumentService {
  Future<void> addImageDocument(ImageDocumentModel imageDocument);
}