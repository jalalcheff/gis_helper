import '../../data/resource/result_pattern.dart';
import '../model/image_document_model.dart';

abstract class ImageDocumentRepository {
  Future<void> addImageDocument(ImageDocumentModel imageDocument);
  Future<Result<List<ImageDocumentModel>>> getImages();
  Future<Result<List<ImageDocumentModel>>> updateAllImagesReomtely();
}