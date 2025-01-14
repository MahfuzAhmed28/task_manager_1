import 'dart:convert';

import 'package:task_manager_1/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthController
{
  static const String? accessToken;
  static const UserModel? userModel;

  static String _accessTokenKey='access-token';
  static String _userDataKey='user-data';

  static Future<void> saveUserData(String accessToken,UserModel model) async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, accessToken);
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
  }

  static Future<void> getUserData() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String? token=sharedPreferences.getString(_accessTokenKey);
    String? userData=sharedPreferences.getString(_userDataKey);

    accessToken=token;
    userModel=UserModel.fromJson(jsonDecode(userData!));
  }

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String? token=sharedPreferences.getString(_accessTokenKey);

    if(token!=null){
      await getUserData();
      return true;
    }
    return false;
  }

  static Future<void> clearUserData() async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}