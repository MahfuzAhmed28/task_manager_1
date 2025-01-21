import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/ui/screens/sign_in_screen.dart';
import 'package:task_manager_1/ui/screens/sign_up_screen.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';
import 'package:task_manager_1/ui/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';
import '../utils/app_colors.dart';

class RessetPasswordScreen extends StatefulWidget {
  const RessetPasswordScreen({super.key, required this.mail, required this.otp});

  static const String name='/forgot-password/resset-password';

  final String mail;
  final String otp;

  @override
  State<RessetPasswordScreen> createState() => _RessetPasswordScreen();
}

class _RessetPasswordScreen extends State<RessetPasswordScreen> {

  final TextEditingController _newPasswordTEController=TextEditingController();
  final TextEditingController _confirmNewPasswordTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  bool _ressetPasswordInProgress=false;
  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80,),
                  Text(
                    'Set password',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    'Minimum length of password should be more than 8 letters',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 28,),
                  TextFormField(
                    controller: _newPasswordTEController,
                    decoration: InputDecoration(
                      hintText: 'New password',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter new password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _confirmNewPasswordTEController,
                    decoration: InputDecoration(
                      hintText: 'Confirm new password'
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter confirm password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28,),
                  Visibility(
                    visible: _ressetPasswordInProgress==false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapConfirmPasswordButton,
                      child: Text('Confirm'),
                    ),
                  ),
                  const SizedBox(height: 48,),
                  Center(
                    child: _buildSignInSection(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
          text: "Already have an account?",
          style: TextStyle(
            color: Colors.grey,
          ),
          children: [
            TextSpan(
                text: ' Sign in',
                style: TextStyle(
                  color: AppColors.themeColor,
                ),
              recognizer: TapGestureRecognizer()
                ..onTap = (){
                  Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (value)=>false);
                }
            )
          ]
      ),
    );
  }

  void _onTapConfirmPasswordButton(){
    if(_formKey.currentState!.validate()){
      if(_newPasswordTEController.text.toString()==_confirmNewPasswordTEController.text.toString()){
        _ressetPassword();
      }
      else{
        showSnackBarMessage(context, 'Please give correct password');
      }
    }
  }

  Future<void> _ressetPassword() async{
    _ressetPasswordInProgress=true;
    setState(() {});
    Map<String,dynamic> _requestBody={
      "email":widget.mail.toString(),
      "OTP":widget.otp.toString(),
      "password":_newPasswordTEController.text
    };
    
    final NetworkResponse response=await NetworkCaller.postRequest(url: Urls.recoverResetPassUrl,body: _requestBody);
    if(response.isSuccess){
      showSnackBarMessage(context, 'Successfully password reset');
    }
    else{
      showSnackBarMessage(context, 'Successfully password reset');
    }
    _ressetPasswordInProgress=false;
    setState(() {});
  }

  @override
  void dispose() {

    _confirmNewPasswordTEController.dispose();
    _newPasswordTEController.dispose();
    super.dispose();
  }
}
