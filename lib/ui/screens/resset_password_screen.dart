import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_1/ui/screens/sign_in_screen.dart';
import 'package:task_manager_1/ui/screens/sign_up_screen.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';

import '../utils/app_colors.dart';

class RessetPasswordScreen extends StatefulWidget {
  const RessetPasswordScreen({super.key});

  static const String name='/forgot-password/resset-password';

  @override
  State<RessetPasswordScreen> createState() => _RessetPasswordScreen();
}

class _RessetPasswordScreen extends State<RessetPasswordScreen> {

  final TextEditingController _newPasswordTEController=TextEditingController();
  final TextEditingController _confirmNewPasswordTEController=TextEditingController();
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
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _confirmNewPasswordTEController,
                    decoration: InputDecoration(
                      hintText: 'Confirm new password'
                    ),
                  ),
                  const SizedBox(height: 28,),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Confirm'),
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

  @override
  void dispose() {

    _confirmNewPasswordTEController.dispose();
    _newPasswordTEController.dispose();
    super.dispose();
  }
}
