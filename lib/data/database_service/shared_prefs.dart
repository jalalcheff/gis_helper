import 'dart:convert';

import 'package:gis_helper/data/resource/account_resource.dart';
import 'package:gis_helper/data/resource/result_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<Result<Map<String,dynamic>>> readDataFromSharedPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');
    if(userData == null){
      return Result.error("no data found");
    }
    else
      {
        return Result.ok(jsonDecode(userData));
      }
  }

  Future<void> saveDataToSharedPrefs(Map<String,dynamic> account) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(account));
  }

  Future<Result<String>> clearSharedPrefs() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return Result.ok("success");
    }
    catch(e){
      return Result.error(e.toString());
    }
  }
}