import 'package:flutter/material.dart';
import 'package:gis_helper/domain/repository/image_document_database_service.dart';

import '../../constants/general_constants.dart';
import '../../domain/model/image_document_model.dart';
import '../../domain/repository/image_document_repository.dart';
import '../database_service/shared_prefs.dart';
import '../resource/result_pattern.dart';
import '../service/image_document_service.dart';

class ImageDocumentRepositoryImp implements ImageDocumentRepository {
  final ImageDocumentService _imageDocumentService;
  final ImageDocumentDatabaseService _imageDocumentDatabaseService;
  ImageDocumentRepositoryImp(this._imageDocumentService, this._imageDocumentDatabaseService);

  @override
  Future<Result<String>> addImageDocument(ImageDocumentModel imageDocument) async {
    try {
      await _imageDocumentService.addImageDocument(imageDocument);
      try{
        final result = await _imageDocumentService.getImages();
        switch(result) {
          case Ok<List<Map<String, dynamic>>>():
            {
              final List<Map<String, dynamic>> newList = result.value;
              newList.add(imageDocument.toFirestore());
              await _imageDocumentDatabaseService.addImageDocument(Ok(newList));
              return Result.ok("success");
            }
          case ErrorValue<List<Map<String, dynamic>>>():
            {
              return ErrorValue(result.e);
            }
        }
      }catch(e){
        return Result.error(e);
      }
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<ImageDocumentModel>>> getImages() async {
    try{
      final result = await _imageDocumentDatabaseService.getImages() ;
      List<Map<String, dynamic>> finalResult = [];
      switch(result) {
        case Ok<List<ImageDocumentModel>>():
          {
            for (var element in result.value) {
              finalResult.add(element.toFirestore());
            }
            print("data from local database");
            return result;
          }
        case ErrorValue<List<ImageDocumentModel>>():
          try {
            final result = await _imageDocumentService.getImages();
            switch(result) {
              case Ok<List<Map<String, dynamic>>>():
                {
                  print("data from server");
                  await _imageDocumentDatabaseService.addImageDocument(result);
                  // here we save the data in local database
                  return Ok(result.value.map((e) =>
                      ImageDocumentModel.fromFirestore(e)).toList());
                }
              case ErrorValue<List<Map<String, dynamic>>>():
                error:  return ErrorValue(result.e);
            }
          } catch (e) {
            print("error : $e");
            return ErrorValue(e.toString());
          }
      }
    }catch(e){
      print("error : $e");
      return ErrorValue(e);
    }
  }
  @override
  Future<Result<List<ImageDocumentModel>>> updateAllImagesReomtely() async {
    try {
      final result = await _imageDocumentService.getImages();
      switch(result) {
        case Ok<List<Map<String, dynamic>>>():
          {
            print("data from server");
            await _imageDocumentDatabaseService.addImageDocument(result);
            // here we save the data in local database
            return Ok(result.value.map((e) =>
                ImageDocumentModel.fromFirestore(e)).toList());
          }
        case ErrorValue<List<Map<String, dynamic>>>():
          error:  return ErrorValue(result.e);
      }
    } catch (e) {
      print("error : $e");
      return ErrorValue(e.toString());
    }
  }
}