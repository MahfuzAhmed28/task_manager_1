import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({super.key,});



  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          CircleAvatar(
            radius: 16,
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rabbil Hasan',
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'rabbial@gmail.com',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }

  @override

  Size get preferredSize =>const Size.fromHeight(kToolbarHeight);
}