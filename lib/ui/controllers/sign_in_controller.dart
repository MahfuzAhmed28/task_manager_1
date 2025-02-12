import 'package:get/get.dart';
import 'package:task_manager_1/data/models/user_model.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
import 'package:task_manager_1/ui/controllers/auth_controller.dart';

class SignInController extends GetxController{
  bool _inProgress=false;

  bool get inProgress=> _inProgress;
  String? _errorMessage;

  String? get errorMessage=> _errorMessage;

  Future<bool> signIn(String email,String password) async {
    bool isSucces=false;
    _inProgress=true;
    update();
    Map<String,dynamic> requestBody={
      "email":email,
      "password":password,
    };

    final NetworkResponse response=await NetworkCaller.postRequest(url: Urls.loginnUrl,body: requestBody);

    if(response.isSuccess){
      String token=response.responseData!['token'];
      UserModel userModel=UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      isSucces=true;
      _errorMessage=null;
    }
    else{

      if(response.statusCode==401)
      {
        _errorMessage='Email or password is invalid!';
      }
      else{
        _errorMessage=response.errorMessage;
      }

    }
    _inProgress=false;
    update();
    return isSucces;
  }
}