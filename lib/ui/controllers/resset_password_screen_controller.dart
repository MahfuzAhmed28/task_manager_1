import 'package:get/get.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
import 'package:task_manager_1/ui/screens/forgot_password_verify_otp_screen.dart';

class RessetPasswordScreenController extends GetxController{
  bool _ressetPasswordInProgress=false;
  bool get ressetPasswordInProgress=> _ressetPasswordInProgress;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;

  Future<bool> ressetPassword(String email,String OTP, String password) async{
    bool isSuccess=false;
    _ressetPasswordInProgress=true;
    update();
    Map<String,dynamic> _requestBody={
      "email":email,
      "OTP":OTP,
      "password":password
    };

    final NetworkResponse response=await NetworkCaller.postRequest(url: Urls.recoverResetPassUrl,body: _requestBody);
    if(response.isSuccess){
      isSuccess=true;
      _errorMessage=null;
    }
    else{
      _errorMessage=response.errorMessage;
    }
    _ressetPasswordInProgress=false;
    update();
    return isSuccess;
  }
}