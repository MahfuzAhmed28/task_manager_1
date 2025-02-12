import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';

class UpdateProfileScreenController extends GetxController{
  bool _udpadeProfileInProgress=false;
  bool get udpadeProfileInProgress=> _udpadeProfileInProgress;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;

  Future<bool> updateProfile(String email, String firstName,String lastName,String mobile,XFile? pickedImage,String password) async{
    bool isSuccess=false;
    _udpadeProfileInProgress=true;
    update();


    Map<String,dynamic> requestBody={
      "email":email,
      "firstName":firstName,
      "lastName":lastName,
      "mobile":mobile,
    };

    if(pickedImage!=null){
      List<int> imageBytes=await pickedImage!.readAsBytes();
      requestBody['photo']= base64Encode(imageBytes);
    }
    if(password.isNotEmpty){
      requestBody['password']=password;
    }

    final NetworkResponse response= await NetworkCaller.postRequest(url: Urls.updateProfile,body: requestBody);

    if(response.isSuccess){
      isSuccess=true;
      _errorMessage=null;
    }
    else{
      _errorMessage=response.errorMessage;
    }
    _udpadeProfileInProgress=false;
    update();
    return isSuccess;
  }
}