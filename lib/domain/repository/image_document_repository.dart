import '../model/image_document_model.dart';

abstract class ImageDocumentRepository {
  Future<void> addImageDocument(ImageDocumentModel imageDocument);
}