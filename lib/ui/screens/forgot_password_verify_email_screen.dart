import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
import 'package:task_manager_1/ui/screens/sign_in_screen.dart';
import 'package:task_manager_1/ui/screens/sign_up_screen.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';
import 'package:task_manager_1/ui/widgets/snack_bar_message.dart';

import '../utils/app_colors.dart';
import 'forgot_password_verify_otp_screen.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  static const String name='/forgot-password/verify-screen';

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreen();
}

class _ForgotPasswordVerifyEmailScreen extends State<ForgotPasswordVerifyEmailScreen> {

  final TextEditingController _emailTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  bool _verifyEmailInProgress=false;

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
                    'Your Email Address',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    'A 6 digits OTP will be sent to your email address',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 28,),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28,),
                  Visibility(
                    visible: _verifyEmailInProgress==false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapVerifyEmailButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
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
                  Navigator.pop(context);
                }
            )
          ]
      ),
    );
  }

  void _onTapVerifyEmailButton(){
    if(_formKey.currentState!.validate()){
      _getRessetPasswordVerifyEmail();
    }
  }

  Future<void> _getRessetPasswordVerifyEmail() async{
    _verifyEmailInProgress=true;
    setState(() {});

    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.verifyEmailUrl(_emailTEController.text.trim()));
    String mail=_emailTEController.text.trim();
    if(response.isSuccess){
      Navigator.pushNamed(context, ForgotPasswordVerifyOtpScreen.name,arguments: mail.toString());
    }
    else{
      showSnackBarMessage(context, response.errorMessage);
    }
    _verifyEmailInProgress=false;
    setState(() {});
  }

  @override
  void dispose() {
    
    _emailTEController.dispose();
    super.dispose();
  }
}
