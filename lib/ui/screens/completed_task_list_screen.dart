import 'package:flutter/material.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
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
            child: Visibility(
              visible: _getCompletedTaskListInProgress==false,
              replacement: CenteredCircularProgressIndicator(),
              child: _buildTaskListView()
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: completedTaskListModel?.taskList?.length ?? 0,
      itemBuilder: (context,indexx) {
        return TaskItemWidget(
          taskModel: completedTaskListModel!.taskList![indexx],
          status: 'Completed',
          color: Colors.green,
        );
      },
    );
  }

  Future<void> _getCompletedTask() async{
    _getCompletedTaskListInProgress=true;
    setState(() {});
    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('Completed'));
    if(response.isSuccess){
      completedTaskListModel=TaskListByStatusModel.fromJson(response.responseData!);
    }
    else{
      showSnackBarMessage(context, response.errorMessage);
    }
    _getCompletedTaskListInProgress=false;
    setState(() {});
    

  }

}







