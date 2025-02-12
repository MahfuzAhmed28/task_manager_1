import 'package:get/get.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
import 'package:task_manager_1/ui/screens/forgot_password_verify_otp_screen.dart';

class ForgotPasswordVerifyOTPScreenController extends GetxController{
  bool _verifyOTPInProgress=false;
  bool get verifyOTPInProgress=> _verifyOTPInProgress;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;

  Future<bool> ressetPasswordVerifyOTP(String mail,String otp) async{
    bool isSuccess=false;
    _verifyOTPInProgress=true;
    update();
    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.verifyOtpUrl(mail, otp));
    if(response.isSuccess){
      isSuccess=true;
    _errorMessage=null;
    }
    else{
      _errorMessage=response.errorMessage;
    }
    _verifyOTPInProgress=false;
    update();
    return isSuccess;
  }
}