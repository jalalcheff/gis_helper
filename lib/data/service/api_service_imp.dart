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
      return Result.ok("added correctly");
    } catch (e) {
      print("add transformer : $e");
      return Result.error(e);
    }
  }
}
