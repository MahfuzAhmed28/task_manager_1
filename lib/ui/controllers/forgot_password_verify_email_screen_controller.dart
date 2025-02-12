import 'package:get/get.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
import 'package:task_manager_1/ui/screens/forgot_password_verify_otp_screen.dart';

class ForgotPasswordVerifyEmailScreenController extends GetxController{
  bool _verifyEmailInProgress=false;
  bool get verifyEmailInProgress=> _verifyEmailInProgress;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;

  Future<bool> getRessetPasswordVerifyEmail(String email) async{
    bool isSuccess=false;
    _verifyEmailInProgress=true;
    update();

    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.verifyEmailUrl(email));
    if(response.isSuccess){
      isSuccess=true;
      _errorMessage=null;
    }
    else{
      _errorMessage=response.errorMessage;
    }
    _verifyEmailInProgress=false;
    update();
    return isSuccess;
  }
}