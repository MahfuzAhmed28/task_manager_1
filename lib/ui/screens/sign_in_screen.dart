import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_1/data/models/user_model.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
import 'package:task_manager_1/ui/controllers/auth_controller.dart';
import 'package:task_manager_1/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager_1/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_1/ui/screens/sign_up_screen.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';
import 'package:task_manager_1/ui/widgets/snack_bar_message.dart';

import '../utils/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name='/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  bool _signInProgress=false;

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
                    'Get started with',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 28,),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true)
                      {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true)
                      {
                        return 'Enter a valid password';
                      }
                      if(value!.length <6 )
                      {
                        return 'Enter a password more than 6 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28,),
                  Visibility(
                    visible: _signInProgress==false,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSignInButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                  const SizedBox(height: 48,),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ForgotPasswordVerifyEmailScreen.name);
                          },
                          child: Text('Forgot Password?',style: TextStyle(color: Colors.grey),),
                        ),
                        const SizedBox(height: 8,),
                        _buildSignUpSection()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void _onTapSignInButton()
  {
    if(_formKey.currentState!.validate()){
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _signInProgress=true;
    setState(() {});
    Map<String,dynamic> requestBody={
      "email":_emailTEController.text.trim(),
      "password":_passwordTEController.text,
    };
    
    final NetworkResponse response=await NetworkCaller.postRequest(url: Urls.loginnUrl,body: requestBody);

    if(response.isSuccess){
      String token=response.responseData!['token'];
      UserModel userModel=UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
    }
    else{
      _signInProgress=false;
      setState(() {});
      if(response.statusCode==401)
      {
        showSnackBarMessage(context, 'Email or Password is invalid! Try again');
      }
      else{
        showSnackBarMessage(context, response.errorMessage);
      }

    }
  }


  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
          text: "Don't have account?",
          style: TextStyle(
            color: Colors.grey,
          ),
          children: [
            TextSpan(
                text: ' Sign up',
                style: TextStyle(
                  color: AppColors.themeColor,
                ),
              recognizer: TapGestureRecognizer()
                ..onTap = (){
                  Navigator.pushNamed(context, SignUpScreen.name);
                }
            )
          ]
      ),
    );
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }
}
