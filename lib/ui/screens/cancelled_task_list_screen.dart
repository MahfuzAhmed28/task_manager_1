import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/data/models/task_model.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
import 'package:task_manager_1/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager_1/ui/utils/app_colors.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';

import '../../data/models/task_list_by_status_model.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/task_status_summay_widget.dart';
import '../widgets/tm_app_bar.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {

  bool _getCancelledTaskListInProgress=false;
  TaskListByStatusModel? cancelledTaskListModel;

  final CancelledTaskController _cancelledTaskController=Get.find<CancelledTaskController>();

  @override
  @override
  void initState() {
    super.initState();
    _getCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GetBuilder<CancelledTaskController>(
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
          status: 'Cancelled',
          color: Colors.red,
        );
      },
    );
  }

  Future<void> _getCancelledTask() async{
    final bool isSuccess=await _cancelledTaskController.getCancelledTaskList();
    if(!isSuccess){

      showSnackBarMessage(context, _cancelledTaskController.errorMessage!);
    }
  }

}







