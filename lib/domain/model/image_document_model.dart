import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ImageDocumentModel extends Equatable {
  final String imageUrl;
  final String title;
  final String descriptions;

  const ImageDocumentModel({
    required this.imageUrl,
    required this.title,
    required this.descriptions,
  });

  factory ImageDocumentModel.fromFirestore(
      Map<String, dynamic> snapshot,
      ) {
    final data = snapshot;
    return ImageDocumentModel(
      imageUrl: data['imageUrl'] as String,
      title: data['title'] as String,
      descriptions: data['descriptions'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "imageUrl": imageUrl,
      "title": title,
      "descriptions": descriptions,
    };
  }

  @override
  List<Object?> get props => [imageUrl, title, descriptions];
}