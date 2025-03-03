import 'package:gis_helper/data/repository/database_service.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';
import 'package:hive_flutter/adapters.dart';

class DatabaseServiceImp extends DatabaseService {
  @override
  Future<Result<List<TransformerResource>>> getAllTransformers() async {
    final box = Hive.box("transformer");
    final transformers = await box.get(
        "transformer", defaultValue: "no data found") as List;
    List<TransformerResource> finalTransformerResult = [];
    transformers.forEach((element){
      finalTransformerResult.add(element);
    });
    print(
        "inside data base service read ${finalTransformerResult[0].yCoordinates}");
    return Result.ok(finalTransformerResult);
  }

  @override
  saveDataIntoDatabase(List<TransformerResource> transform) async {
    var box = Hive.box('transformer');
    print("inside data base service ${transform[0].mahlaOrSector}");
    await box.put('transformer', transform);
    return "success";
  }

  @override
  Future<Result<List<TransformerResource>>> getLatestTransformers() async{
    final box = Hive.box("latest transformers");
    final transformers = await box.get("latest transformers", defaultValue: [Exception("no data")]) as List;
    if(transformers[0] == "no data found"){
      print("inside read latest database service error ${transformers[0]}");
      return Result.error(Exception("no data"));
    }
    else {
      final List<TransformerResource> tempLatestTransformers = [];
      transformers.forEach((transformer) {
        TransformerResource tempTransformer = transformer;
        print("inside read from latest database service : ");
        tempTransformer.printAllData();
        tempLatestTransformers.add(tempTransformer);
      });
      return Result.ok(tempLatestTransformers);
    }
  }

  @override
  Future<String> saveLatestTransformersDataIntoDatabase(List<TransformerResource> transformer) async{
    final box = Hive.box("latest transformers");
    await box.put("latest transformers", transformer);
    return Future.value("success");
  }

}