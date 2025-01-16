
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_manager_1/ui/controllers/auth_controller.dart';

class NetworkResponse{
  final int statusCode;
  final Map<String,dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage='Something went wrong',
  });
}

class NetworkCaller{
  static Future<NetworkResponse> getRequest({required String url}) async{
    try{
      Uri uri=Uri.parse(url);
      debugPrint('URl => $url');
      Response response=await get(uri,headers: {
        'token':AuthController.accessToken ?? ''
      });
      debugPrint('Response Code => ${response.statusCode}');
      debugPrint('Response Data => ${response.body}');
      if(response.statusCode==200){
        final decodeResponse =jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode,responseData: decodeResponse);
      }
      else{
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
      }
    }
    catch(e){
      return NetworkResponse(isSuccess: false, statusCode: -1,errorMessage: e.toString());
    }
  }


  static Future<NetworkResponse> postRequest({required String url, Map<String,dynamic>? body}) async{
    try{
      Uri uri=Uri.parse(url);
      debugPrint('URl => $url');
      debugPrint('Body => $body');
      Response response=await post(uri,
        headers: {'content-type':'application/json','token':AuthController.accessToken ?? ''},
        body: jsonEncode(body));
      debugPrint('Response Code => ${response.statusCode}');
      debugPrint('Response Data => ${response.body}');
      if(response.statusCode==200){
        final decodeResponse =jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode,responseData: decodeResponse);
      }
      else{
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
      }
    }
    catch(e){
      return NetworkResponse(isSuccess: false, statusCode: -1,errorMessage: e.toString());
    }
  }
}