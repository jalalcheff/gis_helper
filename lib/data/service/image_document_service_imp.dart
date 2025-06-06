import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/model/image_document_model.dart';
import 'image_document_service.dart';

class ImageDocumentServiceImp implements ImageDocumentService {

  ImageDocumentServiceImp();

  @override
  Future<void> addImageDocument(ImageDocumentModel imageDocument) async {
    try {
      //await FirebaseFirestore().collection('imageDocuments').add(imageDocument.toFirestore());
    } catch (e) {
      throw Exception('Failed to add image document: $e');
    }
  }
}