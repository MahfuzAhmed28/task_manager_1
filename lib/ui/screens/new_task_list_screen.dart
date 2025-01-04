import 'package:flutter/material.dart';
import 'package:task_manager_1/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_1/ui/utils/app_colors.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';

import '../widgets/task_item_widget.dart';
import '../widgets/task_status_summay_widget.dart';
import '../widgets/tm_app_bar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(

          child: Column(
            children: [
              _buildTasksSummaryByStatus(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildTaskListView(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child:Icon(Icons.add),
      ),

    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 10,
              itemBuilder: (context,indexx) {
                return const TaskItemWidget();
              },
            );
  }

  Widget _buildTasksSummaryByStatus() {
    return const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TaskStatusSummaryCounterWidget(
                    title: 'New',
                    count: '12',
                  ),
                  TaskStatusSummaryCounterWidget(
                    title: 'Progress',
                    count: '9',
                  ),
                  TaskStatusSummaryCounterWidget(
                    title: 'Completed',
                    count: '9',
                  ),
                  TaskStatusSummaryCounterWidget(
                    title: 'Cancelled',
                    count: '9',
                  ),
                ],
              ),
            ),
          );
  }
}







