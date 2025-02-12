import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/data/models/task_model.dart';
import 'package:task_manager_1/ui/controllers/progress_task_controller.dart';
import 'package:task_manager_1/ui/utils/app_colors.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';

import '../../data/models/task_list_by_status_model.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/task_status_summay_widget.dart';
import '../widgets/tm_app_bar.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {

  TaskListByStatusModel? progressTaskListModel;

  final ProgressTaskController _progressTaskController=Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _getProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GetBuilder<ProgressTaskController>(
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
      itemBuilder: (context,indexx) {
        return TaskItemWidget(
          taskModel: taskList[indexx],
          status: 'Progress',
          color: Colors.yellow,
        );
      },
    );
  }

  Future<void> _getProgressTask() async{
    final bool isSuccess=await _progressTaskController.getProgressTaskList();
    if(!isSuccess){

      showSnackBarMessage(context, _progressTaskController.errorMessage!);
    }
    

  }

}







