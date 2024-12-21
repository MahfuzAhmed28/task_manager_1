import 'package:flutter/material.dart';
import 'package:task_manager_1/ui/screens/sign_in_screen.dart';
import 'package:task_manager_1/ui/screens/spalsh_screen.dart';
class TaskManageApp extends StatelessWidget {
  const TaskManageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute:'/',
      onGenerateRoute: (RouteSettings settings){
        late Widget widget;
        if(settings.name==SpalshScreen.name){
           widget =const SpalshScreen();
        }
        else if(settings.name==SignInScreen.name){
          widget =const SignInScreen();
        }
        return MaterialPageRoute(builder: (_) =>widget);
      }

    );
  }
}
