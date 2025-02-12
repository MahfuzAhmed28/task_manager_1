import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/ui/screens/cancelled_task_list_screen.dart';
import 'package:task_manager_1/ui/screens/completed_task_list_screen.dart';
import 'package:task_manager_1/ui/screens/new_task_list_screen.dart';
import 'package:task_manager_1/ui/screens/progress_task_list_screen.dart';

class MainBottomNavController extends GetxController {
  var selectedIndex = 0.obs;
}
class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static const String name='/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final MainBottomNavController controller = Get.put(MainBottomNavController());
  final List<Widget> _screens=const [
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CompletedTaskListScreen(),
    CancelledTaskListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Obx(() => _screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => NavigationBar(
        selectedIndex: controller.selectedIndex.value,

        onDestinationSelected: (int index) => controller.selectedIndex.value = index,
        destinations: const[
          NavigationDestination(icon: Icon(Icons.new_label_outlined), label: 'New'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel_outlined), label: 'Canceled'),
        ],
        indicatorColor: Colors.green,
      ),
      ),
    );
  }
}
