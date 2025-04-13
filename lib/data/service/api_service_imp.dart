import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gis_helper/data/repository/api_srevice.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';

class ApiServiceImp implements ApiService {
  @override
  Future<Result<List<Map<String, dynamic>>>> getAllTransformers() async {
    print("in service ");
    try {
      final firebaseData = await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three transformers")
          .collection("transformers")
          .get();
      final List<Map<String, dynamic>> docList =
          firebaseData.docs.map((element) => element.data()).toList();
      print("data inside api service ${firebaseData.docs.toList()[0].data()}");
      return Result.ok(docList);
    } catch (e) {
      print("get all service is : ${e}");
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<Map<String,dynamic>>>> getLatestChanges() async {
    try {
      final firebaseData = await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three transformers")
          .collection("last changes")
          .get();
      final List<Map<String,dynamic>> lastChanges = (firebaseData.docs.map((element){
        return element.data();
      })).toList().sublist(0, 3);
      lastChanges.forEach((element) {
        print("last chnges service is : ${element.values}");
      });
      return Result.ok(lastChanges.sublist(0, 3));
    } catch (e) {
      print("latest changes servis is : $e");
      return Result.error(e);
    }
  }

  @override
  Future<Result<dynamic>> addTransformer(TransformerResource transformer, String path) async {
    List<Map<String,dynamic>> lastChangesData = [];
    List<Map<String,dynamic>> lastChangesTempData = [];

    try {
      await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three transformers")
          .collection("transformers")
          .doc(path)
          .set({
        'feederName': transformer.feederName,
        'isItOverhead': transformer.isItOverhead,
        'isItPrivate': transformer.isItPrivate,
        'transformerSerialNumber': transformer.transformerSerialNumber,
        'mahlaOrSector': transformer.mahlaOrSector,
        'substationName': transformer.substationName,
        'transformerCapacity': transformer.transformerCapacity,
        'transformerName': transformer.transformerName,
        'xCoordinates': transformer.xCoordinates,
        'yCoordinates': transformer.yCoordinates,
        'zuqaqOrBlock': transformer.zuqaqOrBlock,
      });

      await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three transformers")
          .collection("last changes")
          .doc(path)
          .set({
        'feederName': transformer.feederName,
        'isItOverhead': transformer.isItOverhead,
        'isItPrivate': transformer.isItPrivate,
        'transformerSerialNumber': transformer.transformerSerialNumber,
        'mahlaOrSector': transformer.mahlaOrSector,
        'substationName': transformer.substationName,
        'transformerCapacity': transformer.transformerCapacity,
        'transformerName': transformer.transformerName,
        'xCoordinates': transformer.xCoordinates,
        'yCoordinates': transformer.yCoordinates,
        'zuqaqOrBlock': transformer.zuqaqOrBlock,
        'created_at' : DateTime.now().toIso8601String(),
      });
      Result<List<Map<String, dynamic>>> lastChanges = await getLatestChanges();

      switch(lastChanges) {
        case Ok<List<Map<String, dynamic>>>():
          {
            lastChanges.value.map((element){
              print("lst chng is ${element.values.first}");
              lastChangesData.insert(0, element);
            });
          }
        case ErrorValue<List<Map<String, dynamic>>>():
          {
            print("last changes error is ${lastChanges.e}");
            return ErrorValue(lastChanges.e);
          }
      }
      //for(var lastChangeDataElement in lastChangesData){
       lastChangesData.forEach((element) async {
         await FirebaseFirestore.instance
             .collection("sader three")
             .doc("sader three transformers")
             .collection("last changes").doc("9 9").delete();
      });
/*      await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three transformers")
          .collection("last changes").doc("11").delete();*/
      print("delete success");
      //};
      int count = 0;
      lastChangesData.forEach((element){
      print("last changes list ${element.values.first}");
      if(count < 3){
        lastChangesTempData.add(element.values.first);
      }
      count++;
      });
       lastChangesTempData.map((transformer) async {
        await FirebaseFirestore.instance
            .collection("sader three")
            .doc("sader three transformers")
            .collection("last changes")
            .doc(path)
            .set({
          'feederName': transformer['feederName'],
          'isItOverhead': transformer['isItOverhead'],
          'isItPrivate': transformer['isItPrivate'],
          'transformerSerialNumber': transformer['transformerSerialNumber'],
          'mahlaOrSector': transformer['mahlaOrSector'],
          'substationName': transformer['substationName'],
          'transformerCapacity': transformer['transformerCapacity'],
          'transformerName': transformer['transformerName'],
          'xCoordinates': transformer['xCoordinates'],
          'yCoordinates': transformer['yCoordinates'],
          'zuqaqOrBlock': transformer['zuqaqOrBlock'],
          'created_at' : DateTime.now().toIso8601String(),
        });
      });
      return Result.ok("added correctly");
    } catch (e) {
      print("add transformer : $e");
      return Result.error(e);
    }
  }
}
