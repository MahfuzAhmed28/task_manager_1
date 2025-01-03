import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_1/ui/screens/sign_in_screen.dart';
import 'package:task_manager_1/ui/screens/sign_up_screen.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';

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
                  ),
                  const SizedBox(height: 28,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPasswordVerifyOtpScreen.name);
                    },
                    child: Icon(Icons.arrow_circle_right_outlined),
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

  @override
  void dispose() {
    
    _emailTEController.dispose();
    super.dispose();
  }
}
