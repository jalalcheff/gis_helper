import '../../domain/model/image_document_model.dart';
import '../resource/result_pattern.dart';

abstract class ImageDocumentService {
  Future<void> addImageDocument(ImageDocumentModel imageDocument);
  Future<Result<List<Map<String, dynamic>>>> getImages();
}