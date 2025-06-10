import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/resource/result_pattern.dart';
import '../../domain/model/image_document_model.dart';
import 'image_document_service.dart';

class ImageDocumentServiceImp implements ImageDocumentService {
  final FirebaseFirestore _firestore;

  ImageDocumentServiceImp(this._firestore);

  @override
  Future<void> addImageDocument(ImageDocumentModel imageDocument) async {
    try {
      await _firestore.collection('sader three').doc('sader three transformers').collection('news').add(imageDocument.toFirestore());
    } catch (e) {
      throw Exception('Failed to add image document: $e');
    }
  }

  @override
  Future<Result<List<Map<String, dynamic>>>> getImages() async {
    try {
      final querySnapshot = await _firestore.collection('sader three').doc('sader three transformers').collection('news').get();
      final List<Map<String, dynamic>> images = querySnapshot.docs.map((doc) => doc.data()).toList();
      return Result.ok(images);
    } catch (e) {
      return Result.error(e);
    }
  }
}