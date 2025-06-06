part of 'image_document_cubit.dart';

abstract class ImageDocumentState {}

class ImageDocumentInitial extends ImageDocumentState {}

class ImageDocumentLoading extends ImageDocumentState {}

class ImageDocumentSuccess extends ImageDocumentState {}

class ImageDocumentFailure extends ImageDocumentState {
  final String error;

  ImageDocumentFailure(this.error);
}