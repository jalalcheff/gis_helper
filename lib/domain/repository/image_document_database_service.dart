
import '../../data/resource/result_pattern.dart';
import '../model/image_document_model.dart';

abstract class ImageDocumentDatabaseService {
  Future<Result<List<ImageDocumentModel>>> addImageDocument(Result<List<Map<String,dynamic>>> imageDocument);
  Future<Result<List<ImageDocumentModel>>> getImages();
}