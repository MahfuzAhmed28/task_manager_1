import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/ui/controllers/forgot_password_verify_otp_screen_controller.dart';
import 'package:task_manager_1/ui/screens/resset_password_screen.dart';
import 'package:task_manager_1/ui/screens/sign_in_screen.dart';
import 'package:task_manager_1/ui/screens/sign_up_screen.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';
import 'package:task_manager_1/ui/widgets/snack_bar_message.dart';

import '../../data/utils/urls.dart';
import '../utils/app_colors.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgotPasswordVerifyOtpScreen({super.key, required this.mail});

  static const String name='/forgot-password/verify-otp';

  final String mail;
  @override
  State<ForgotPasswordVerifyOtpScreen> createState() => _ForgotPasswordVerifyOtpScreen();
}

class _ForgotPasswordVerifyOtpScreen extends State<ForgotPasswordVerifyOtpScreen> {

  final TextEditingController _otpTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  final ForgotPasswordVerifyOTPScreenController _forgotPasswordVerifyOTPScreenController=Get.find<ForgotPasswordVerifyOTPScreenController>();



  bool _verifyOTPInProgress=false;




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
                    'PIN Verification',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    'A 6 digits OTP has been sent to your email address',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 28,),
                  _buildPinCodeTextField(),
                  const SizedBox(height: 28,),
                  GetBuilder<ForgotPasswordVerifyOTPScreenController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.verifyOTPInProgress==false,
                        replacement: CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            _onTapOTPVerifyButton();
                          },
                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
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

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _otpTEController,
      validator: (String? value){
        if(value?.trim().trim().isEmpty ?? true){
          return 'Enter OTP';
        }
        return null;
      },
      appContext: context,
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

  void _onTapOTPVerifyButton(){
    if(_formKey.currentState!.validate()){
      _ressetPasswordVerifyOTP();
    }
  }

  Future<void> _ressetPasswordVerifyOTP() async{
    String _mail=widget.mail;
    String _otp=_otpTEController.text.trim();
    bool isSuccess=await _forgotPasswordVerifyOTPScreenController.ressetPasswordVerifyOTP(_mail, _otp);
    if(isSuccess){
      //Navigator.pushNamed(context, RessetPasswordScreen.name,arguments: {'mail':widget.mail,'otp':_otpTEController.text.trim()});
      Get.toNamed(RessetPasswordScreen.name,arguments: {'mail':_mail,'otp':_otp});
    }
    else{
      showSnackBarMessage(context, _forgotPasswordVerifyOTPScreenController.errorMessage!);
    }
  }

  @override
  void dispose() {

    _otpTEController.dispose();
    super.dispose();
  }
}
