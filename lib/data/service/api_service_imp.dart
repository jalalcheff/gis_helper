import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gis_helper/data/repository/api_srevice.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:gis_helper/data/resource/transformer_resource.dart';

import '../database_service/shared_prefs.dart';

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
  Future<Result<List<Map<String, dynamic>>>> getLatestChanges() async {
    try {
      final firebaseData = await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three transformers")
          .collection("last changes")
          .get();
      final List<Map<String, dynamic>> lastChanges =
      (firebaseData.docs.map((element) {
        return element.data();
      })).toList();
      lastChanges.forEach((element) {
        print("last chnges service is : ${element.values}");
      });
      return Result.ok(lastChanges);
    } catch (e) {
      print("latest changes servis is : $e");
      return Result.error(e);
    }
  }

  @override
  Future<Result<dynamic>> addTransformer(TransformerResource transformer,
      String path) async {
     String updateOrDelete = "";
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
        'created_at': DateTime.now().toIso8601String(),
      });
      final document = await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three transformers")
          .collection("transformers")
          .doc(path).get();
      if(document.exists){
        updateOrDelete = "update";
      }
      else{
        updateOrDelete = "add";
      }
      try {
        await FirebaseFirestore.instance
            .collection("sader three")
            .doc("sader three transformers")
            .collection("last changes")
            .doc(updateOrDelete)
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
          'created_at': DateTime.now().toIso8601String(),
        });
      } catch (e) {
        await FirebaseFirestore.instance
            .collection("sader three")
            .doc("sader three transformers")
            .collection("transformers")
            .doc(path)
            .delete();
        return Result.error(e);
      }
      return Result.ok("added correctly");
    } catch (e) {
      print("add transformer : $e");
      return Result.error(e);
    }
  }

  @override
  Future<Result<String>> signIn(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Result<Map<String, dynamic>> userData = await _getLoginaData(
          auth.currentUser!.uid);
      switch (userData) {
        case Ok<Map<String, dynamic>>():
          {
            await SharedPrefs().saveDataToSharedPrefs(userData.value);
            return Result.ok("successful");
          }
        case ErrorValue<Map<String, dynamic>>():
          return Result.error(userData.e);
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }

  Future<Result<Map<String, dynamic>>> _getLoginaData(String uid) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three accounts")
          .collection("accounts")
          .doc(uid)
          .get();
      print("to ensure : ${result.data()} and uid : $uid");
      return Result.ok(result.data()!);
    }
    catch (error) {
      return Result.error(error.toString());
    }
  }

  @override
  Future<Result<String>> deleteTransformer(TransformerResource transformer) async {
    try {
      await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three transformers")
          .collection("transformers").doc(
          "${transformer.transformerName} ${transformer
              .transformerSerialNumber}").delete();
      await FirebaseFirestore.instance
          .collection("sader three")
          .doc("sader three transformers")
          .collection("last changes")
          .doc("delete")
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
        'created_at': DateTime.now().toIso8601String(),
      });
      return Result.ok("deleted correctly");
    } catch (e) {
      return Result.error(e);
    }
  }
}