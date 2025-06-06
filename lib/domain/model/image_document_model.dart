import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ImageDocumentModel extends Equatable {
  final String? id;
  final String imageUrl;
  final String title;
  final String subtitle;

  const ImageDocumentModel({
    this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  factory ImageDocumentModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return ImageDocumentModel(
      id: snapshot.id,
      imageUrl: data?['imageUrl'] as String,
      title: data?['title'] as String,
      subtitle: data?['subtitle'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "imageUrl": imageUrl,
      "title": title,
      "subtitle": subtitle,
    };
  }

  @override
  List<Object?> get props => [id, imageUrl, title, subtitle];
}