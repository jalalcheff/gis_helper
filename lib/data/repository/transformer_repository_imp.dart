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
//    print("database data is ${database.value}");
    final Result<List<TransformerResource>> finalResult;
    final transformers = await _apiService.getAllTransformers();
    print("inside get all transformer repository ${(transformers as Ok<
        List<Map<String, dynamic>>>).value}");
    switch (transformers) {
      case Ok<List<Map<String, dynamic>>>():
        {
          final Set feeders = {};
          int counter = 0;
          List<TransformerResource> tempTransformers = [];
          transformers.value.forEach((transformer) {
            print("inside transformer repository ${transformer.values}");
            tempTransformers.add(TransformerResource.fromJson(transformer));
            feeders.add(tempTransformers[counter].feederName);
            counter++;
          });
          //print("feeders no is ${feeders.length} which are : ${feeders.toList()} and ${feeders.toList()[0]}");
          print("feeder num are ${feeders.length}");
          feeders.toList().forEach((feeder) {
            print("this is feeder $feeder");
          });
          print("inside repository ${tempTransformers[0].mahlaOrSector}");
          await _databaseService.saveDataIntoDatabase(tempTransformers);
          final databaseData = await _databaseService.getAllTransformers();
          print(
              "inside repository database ${(databaseData as Ok<
                  List<TransformerResource>>).value[0].mahlaOrSector}");
          return Result.ok(
              (databaseData as Ok<List<TransformerResource>>).value);
        }
      case ErrorValue<List<Map<String, dynamic>>>():
        {
          //  print("transformer repo imp is : ${transformers.e}");
          final database = await _databaseService.getAllTransformers();
          switch (database) {
            case Ok<List<TransformerResource>>():
              {
                finalResult = Ok(database.value);
              }
            case ErrorValue<List<TransformerResource>>():
              {
                finalResult = ErrorValue(database.e);
              }
          }
          return finalResult;
        }
    }
  }

  @override
  Future<Result<List<TransformerResource>>> getAllTransformersLocally() async {
    final databaseData = await _databaseService.getAllTransformers();
    print(
        "inside repository database ${(databaseData as Ok<
            List<TransformerResource>>).value[0].mahlaOrSector}");
    return Result.ok((databaseData as Ok<List<TransformerResource>>).value);
  }

  @override
  Future<Result<List<TransformerResource>>> getLastChangesTransformers() async {
    final transformers = await _apiService.getLatestChanges();
    final List<TransformerResource> tempTransformers = [];
    switch (transformers) {
      case ErrorValue<List>():
        {
          final latestTransformerDatabase =
          await _databaseService.getLatestTransformers();
          print("error and that is list ");
          switch (latestTransformerDatabase) {
            case Ok<List<TransformerResource>>():
              {
                print("latest transformer locally");
                printDataOfResult(latestTransformerDatabase);
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
              print("data from database repository");
              printDataOfResult(latestTransformerDatabase);
            }
          case ErrorValue<List<TransformerResource>>():
            print("لا يوجد بيانات تاكد من الاتصال بالانترنت");
        }
        //  printDataOfResult(latestTransformerDatabase);
        return latestTransformerDatabase;
    }
  }

  saveDataToDatabase() {}

  printDataOfResult(Result<List<TransformerResource>> transformer) {
    (transformer as Ok<List<TransformerResource>>).value.forEach((transformer) {
      transformer.printAllData();
    });
  }

  @override
  Future<Result<dynamic>> addTransformerData (TransformerModel transformer,
      String path) async{
    print("transformer model data inside transformer repo is ${transformer.feederName}");
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
    print("transformer resource data inside transformer repo is ${transformer.feederName}");
    transformerResource.printAllData();
    final data = await _apiService.addTransformer(transformerResource, path);
    return data;
  }
}
