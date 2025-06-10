part of 'get_image_documents_cubit.dart';

abstract class GetImageDocumentsState {}

class GetImageDocumentsInitial extends GetImageDocumentsState {}

class GetImageDocumentsLoading extends GetImageDocumentsState {}

class GetImageDocumentsSuccess extends GetImageDocumentsState {
  final List<ImageDocumentModel> images;

  GetImageDocumentsSuccess(this.images);
}

class GetImageDocumentsError extends GetImageDocumentsState {
  final String message;

  GetImageDocumentsError(this.message);
}