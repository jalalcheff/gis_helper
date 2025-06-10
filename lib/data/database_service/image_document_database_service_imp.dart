import 'dart:ui';

import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/model/image_document_model.dart';
import 'package:gis_helper/domain/repository/image_document_database_service.dart';
import 'package:hive_flutter/adapters.dart';

class ImageDocumentDatabaseServiceImp extends ImageDocumentDatabaseService {
  @override
  Future<Result<List<ImageDocumentModel>>> addImageDocument(Result<List<Map<String,dynamic>>> imageDocument) async {
    final List<ImageDocumentModel> tempImagesDocumentList = [];
    final Result<List<ImageDocumentModel>> finalResult;
    switch(imageDocument) {
      case Ok<List<Map<String, dynamic>>>():
        {
          for (var imageDocument in imageDocument.value) {
            tempImagesDocumentList.add(ImageDocumentModel.fromFirestore(imageDocument));
          }
          var box = Hive.box('images');
          // print("inside data base service ${transform[0].mahlaOrSector}");
          await box.put('images', tempImagesDocumentList);
          finalResult = Ok(tempImagesDocumentList);
        }
      case ErrorValue<List<Map<String, dynamic>>>():
        finalResult = ErrorValue(imageDocument.e);
    }
    return finalResult;
  }

  @override
  Future<Result<List<ImageDocumentModel>>> getImages() async {
    final box = Hive.box("images");
    try{
      final List<ImageDocumentModel> tempImageDocument = [];
      final imageDocuments = await box.get("images", defaultValue: null);
      if(imageDocuments == null){
        return Result.error(Exception("no data"));
      }
      for(var imageDocument in imageDocuments as List){
        if(imageDocument is ImageDocumentModel) {
          tempImageDocument.add(imageDocument);
        }
      }
      if(tempImageDocument.isEmpty){
        return Result.error(Exception("no valid transformers found"));
      }
      return Result.ok(tempImageDocument);
    }
    catch(e){
      return ErrorValue(e);
    }
  }
}