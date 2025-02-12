import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/ui/screens/update_profile_screen.dart';
import 'package:task_manager_1/ui/controllers/auth_controller.dart';
import 'package:task_manager_1/data/models/user_model.dart';
import 'package:task_manager_1/ui/screens/sign_in_screen.dart';

import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({super.key,this.fromUpdateProfile=false});

  final bool fromUpdateProfile;


  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: MemoryImage(base64Decode(AuthController.userModel?.photo ?? '')),
            onBackgroundImageError: (_,__) => const Icon(Icons.percent_outlined),
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if(!fromUpdateProfile){
                  Get.toNamed(UpdateProfileScreen.name); //Can't click update screen appbar because already there
                }

              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userModel?.fullName ?? '',
                    style: textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    AuthController.userModel?.email ?? '',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await AuthController.clearUserData();
              Get.offAllNamed(SignInScreen.name);
            },
            icon: Icon(Icons.logout)),
        ],
      ),
    );
  }

  @override

  Size get preferredSize =>const Size.fromHeight(kToolbarHeight);
}