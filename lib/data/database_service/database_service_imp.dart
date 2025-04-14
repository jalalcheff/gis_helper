import 'dart:ui';

import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:hive_flutter/adapters.dart';

class DatabaseServiceImp extends DatabaseService {
  @override
  Future<Result<List<TransformerResource>>> getAllTransformers() async {
    final box = Hive.box("transformer");
    try{
      final List<TransformerResource> tempTransformer = [];
      final transformers = await box.get("transformer", defaultValue: null);
      if(transformers == null){
        return Result.error(Exception("no data"));
      }
      for(var transformer in transformers as List){
        if(transformer is TransformerResource) {
          tempTransformer.add(transformer);
        }
        }
      if(tempTransformer.isEmpty){
        return Result.error(Exception("no valid transformers found"));
      }
      return Result.ok(tempTransformer);
    }
    catch(e){
      return ErrorValue(e);
    }

    final Result<List<TransformerResource>> finalResult;
    final transformers = await box.get(
        "transformer", defaultValue: [""]) as List;
    List<TransformerResource> finalTransformerResult = [];
    switch(transformers){
      case List<TransformerResource>():{
      for(TransformerResource transformer in transformers){
        finalTransformerResult.add(transformer);
      }
        finalResult = Ok(finalTransformerResult);
      }
      default : {
        finalResult = ErrorValue("error");
      }
    }
  /*  print(
        "inside data base service read ${finalTransformerResult[0].yCoordinates}");*/
    return finalResult;
  }

  @override
  Future<Result<List<TransformerResource>>> saveDataIntoDatabase(Result<List<Map<String,dynamic>>> transform) async {
    final List<TransformerResource> tempTransformerList = [];
    final Result<List<TransformerResource>> finalResult;
    switch(transform) {
      case Ok<List<Map<String, dynamic>>>():
        {
          for (var transformer in transform.value) {
            tempTransformerList.add(TransformerResource.fromJson(transformer));
          }
          var box = Hive.box('transformer');
          // print("inside data base service ${transform[0].mahlaOrSector}");
          await box.put('transformer', tempTransformerList);
          finalResult = Ok(tempTransformerList);
        }
      case ErrorValue<List<Map<String, dynamic>>>():
        finalResult = ErrorValue(transform.e);
    }
    return finalResult;
  }

  @override
  Future<Result<List<TransformerResource>>> getLatestTransformers() async {
    final box = Hive.box("latest transformers");
    try {
      final transformers = await box.get("latest transformers", defaultValue: null);
      if (transformers == null) {
        return Result.error(Exception("no data"));
      }
      final List<TransformerResource> tempLatestTransformers = [];
      for (var transformer in transformers as List) {
        if (transformer is TransformerResource) {
          tempLatestTransformers.add(transformer);
        }
      }
      if (tempLatestTransformers.isEmpty) {
        return Result.error(Exception("no valid transformers found"));
      }
      return Result.ok(tempLatestTransformers);
    } catch (e) {
      return Result.error(Exception("Error reading latest transformers: $e"));
    }
  }

  @override
  Future<Result<List<TransformerResource>>> saveLatestTransformersDataIntoDatabase(Result<List<Map<String,dynamic>>> transformer) async{
    switch(transformer) {
      case Ok<List<Map<String,dynamic>>>():
        {
          List<TransformerResource> tempTransformers = [];
          for (var transformer in transformer.value) {
            tempTransformers.add(TransformerResource.fromJson(transformer));
          }
          final box = Hive.box("latest transformers");
          await box.put("latest transformers", tempTransformers);
          return Ok(tempTransformers);
        }
      case ErrorValue<List<Map<String,dynamic>>>():
        return ErrorValue("cannot save latest chnges locally");
    }
  }
}