import 'package:flutter/material.dart';
import 'package:task_manager_1/ui/screens/new_task_list_screen.dart';
import 'package:task_manager_1/ui/screens/progress_task_list_screen.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static const String name='/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedindex=0;
  final List<Widget> _screens=const [
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    NewTaskListScreen(),
    NewTaskListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _screens[_selectedindex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedindex,
        onDestinationSelected: (int index){
          _selectedindex=index;
          setState(() {});
        },
        destinations: const[
          NavigationDestination(icon: Icon(Icons.new_label_outlined), label: 'New'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel_outlined), label: 'Canceled'),
        ]
      ),
    );
  }
}
