import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_1/ui/screens/sign_in_screen.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';

import '../utils/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name='/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUnScreenState();
}

class _SignUnScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _mobileTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
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
                    'Join With Us',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 28,),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 28,),
                  ElevatedButton(
                    onPressed: () {},
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
          text: "Already have account?",
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
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }
}
