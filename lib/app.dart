import 'package:flutter/material.dart';
import 'package:task_manager_1/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_1/ui/screens/forgot_password_verify_email_screen.dart';
import 'package:task_manager_1/ui/screens/forgot_password_verify_otp_screen.dart';
import 'package:task_manager_1/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_1/ui/screens/resset_password_screen.dart';

import 'package:task_manager_1/ui/screens/sign_in_screen.dart';
import 'package:task_manager_1/ui/screens/sign_up_screen.dart';
import 'package:task_manager_1/ui/screens/spalsh_screen.dart';
import 'package:task_manager_1/ui/screens/update_profile_screen.dart';
import 'package:task_manager_1/ui/utils/app_colors.dart';
class TaskManageApp extends StatelessWidget {
  const TaskManageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute:'/',
      theme: ThemeData(
          colorSchemeSeed: AppColors.themeColor,
          textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600
          ),
          titleSmall: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16,),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            textStyle: TextStyle(
              fontSize: 16,
            ),
          ),
        )
      ),
      onGenerateRoute: (RouteSettings settings){
        late Widget widget;
        if(settings.name==SpalshScreen.name){
           widget =const SpalshScreen();
        }
        else if(settings.name==SignInScreen.name){
          widget =const SignInScreen();
        }
        else if(settings.name==SignUpScreen.name){
          widget=const SignUpScreen();
        }
        else if(settings.name==ForgotPasswordVerifyEmailScreen.name){
          widget=const ForgotPasswordVerifyEmailScreen();
        }
        else if(settings.name==ForgotPasswordVerifyOtpScreen.name){
          widget=const ForgotPasswordVerifyOtpScreen();
        }
        else if(settings.name==RessetPasswordScreen.name){
          widget=const RessetPasswordScreen();
        }
        else if(settings.name==MainBottomNavScreen.name){
          widget=const MainBottomNavScreen();
        }
        else if(settings.name==AddNewTaskScreen.name){
          widget=const AddNewTaskScreen();
        }
        else if(settings.name==UpdateProfileScreen.name){
          widget=const UpdateProfileScreen();
        }
        return MaterialPageRoute(builder: (_) =>widget);
      }

    );
  }
}

