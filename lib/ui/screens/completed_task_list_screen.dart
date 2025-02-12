import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/data/models/task_model.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
import 'package:task_manager_1/ui/controllers/completed_task_controller.dart';
import 'package:task_manager_1/ui/utils/app_colors.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';

import '../../data/models/task_list_by_status_model.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/task_status_summay_widget.dart';
import '../widgets/tm_app_bar.dart';

class CompletedTaskListScreen extends StatefulWidget {
  const CompletedTaskListScreen({super.key});

  @override
  State<CompletedTaskListScreen> createState() => _CompletedTaskListScreenState();
}

class _CompletedTaskListScreenState extends State<CompletedTaskListScreen> {

  bool _getCompletedTaskListInProgress=false;
  TaskListByStatusModel? completedTaskListModel;

  final CompletedTaskController _completedTaskController=Get.find<CompletedTaskController>();

  @override
  @override
  void initState() {
    super.initState();
    _getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GetBuilder<CompletedTaskController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.inProgress==false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: _buildTaskListView(controller.taskList)
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView(List<TaskModel> taskList) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: taskList.length,
      itemBuilder: (context,index) {
        return TaskItemWidget(
          taskModel: taskList[index],
          status: 'Completed',
          color: Colors.green,
        );
      },
    );
  }

  Future<void> _getCompletedTask() async{
    final bool isSuccess= await _completedTaskController.getCompletedTaskList();
    if(!isSuccess){
      showSnackBarMessage(context, _completedTaskController.errorMessage!);
    }
    

  }

}







