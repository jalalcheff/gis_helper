import 'package:gis_helper/data/repository/api_srevice.dart';
import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:gis_helper/domain/transformer_repository.dart';

import '../../domain/model/transformer_model.dart';

class TransformerRepositoryImp implements TransformerRepository {
  final ApiService _apiService;
  final DatabaseService _databaseService;

  TransformerRepositoryImp({required ApiService apiService,
    required DatabaseService databaseService})
      : _apiService = apiService,
        _databaseService = databaseService;

  @override
  Future<Result<List<TransformerResource>>> getAllTransformers() async {
  final Result<List<TransformerResource>> databaseTransformers = await _databaseService.getAllTransformers();
  switch(databaseTransformers) {
    case Ok<List<TransformerResource>>():
      return databaseTransformers;
    case ErrorValue<List<TransformerResource>>():
      {
        print("inside transformer repo search for transformer in internet");
        final Result<List<TransformerResource>> finalResult;
        final transformers = await _apiService.getAllTransformers();
        switch (transformers) {
          case Ok<List<Map<String, dynamic>>>():
            {
                final result = _databaseService.saveDataIntoDatabase(transformers);
                print("inside transformer repo ${result.runtimeType}");
                return result;
            }
            case ErrorValue<List<Map<String, dynamic>>>():
            return ErrorValue(transformers.e);
        }
      }
  }
  }

  @override
  Future<Result<List<TransformerResource>>> getAllTransformersLocally() async {
    final databaseData = await _databaseService.getAllTransformers();
    return databaseData;
  }

  @override
  Future<Result<List<TransformerResource>>> getLastChangesTransformers() async {
    // final transformers = await _apiService.getLatestChanges();
    final transformers = await _databaseService.getLatestTransformers();
    /*switch (transformers) {
      case ErrorValue<List>():
        {
          final latestTransformerDatabase =
          await _databaseService.getLatestTransformers();
          print("error and that is list ");
          switch (latestTransformerDatabase) {
            case Ok<List<TransformerResource>>():
              {
                print("latest transformer locally");
              }
            case ErrorValue<List<TransformerResource>>():
              {
                print("تاكد من الاتصال بالانترنت");
              }
          }
          //printDataOfResult(latestTransformerDatabase);
          return latestTransformerDatabase;
        }
      case Ok<List<Map<String, dynamic>>>():
        {
          transformers.value.forEach((transformer) {
            Map<String, dynamic> tempTransformer =
            transformer as Map<String, dynamic>;
            tempTransformers.add(TransformerResource.fromJson(tempTransformer));
            print("inside latest changes repo : ${tempTransformer.values}");
          });
        }
        final isSuccess = await _databaseService
            .saveLatestTransformersDataIntoDatabase(tempTransformers);
        print("is it success inside transofmer repo save $isSuccess");
        final latestTransformerDatabase =
        await _databaseService.getLatestTransformers();
        switch (latestTransformerDatabase) {
          case Ok<List<TransformerResource>>():
            {
              _databaseService.saveLatestTransformersDataIntoDatabase(latestTransformerDatabase.value);
              print("data from database repository");
            }
          case ErrorValue<List<TransformerResource>>():
            {
              print("لا يوجد بيانات تاكد من الاتصال بالانترنت");
              return latestTransformerDatabase;
            }

        }
        //  printDataOfResult(latestTransformerDatabase);
        return latestTransformerDatabase;
    }*/
    switch (transformers) {
      case Ok<List<TransformerResource>>():
        {
          return transformers;
        }
      case ErrorValue<List<TransformerResource>>():
        {
          final apiLatestChangesData = await _apiService.getLatestChanges();
          final localResult = await _databaseService
              .saveLatestTransformersDataIntoDatabase(apiLatestChangesData);
          return localResult;
        }
    }
  }

    saveDataToDatabase() {}

    printDataOfResult(Result<List<TransformerResource>> transformer) {
      (transformer as Ok<List<TransformerResource>>).value.forEach((
          transformer) {});
    }

    @override
    Future<Result<dynamic>> addTransformerData(TransformerModel transformer, String path) async {
      print("transformer model data inside transformer repo is ${transformer
          .feederName}");
      TransformerResource transformerResource = TransformerResource(
          feederName: transformer.feederName,
          isItOverhead: transformer.isItOverhead,
          isItPrivate: transformer.isItPrivate,
          mahlaOrSector: transformer.mahlaOrSector,
          substationName: transformer.substationName,
          transformerCapacity: transformer.transformerCapacity,
          transformerName: transformer.transformerName,
          transformerSerialNumber: transformer.transformerSerialNumber,
          xCoordinates: transformer.xCoordinates,
          yCoordinates: transformer.yCoordinates,
          zuqaqOrBlock: transformer.zuqaqOrBlock);
      print("transformer resource data inside transformer repo is ${transformer
          .feederName}");
      transformerResource.printAllData();
      final data = await _apiService.addTransformer(transformerResource, path);
      return data;
    }
  }
