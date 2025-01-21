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

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {

  bool _getCancelledTaskListInProgress=false;
  TaskListByStatusModel? cancelledTaskListModel;

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
            child: Visibility(
              visible: _getCancelledTaskListInProgress==false,
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
      itemCount: cancelledTaskListModel?.taskList?.length ?? 0,
      itemBuilder: (context,indexx) {
        return TaskItemWidget(
          taskModel: cancelledTaskListModel!.taskList![indexx],
          status: 'Cancelled',
          color: Colors.red,
        );
      },
    );
  }

  Future<void> _getCancelledTask() async{
    _getCancelledTaskListInProgress=true;
    setState(() {});
    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('Cancelled'));
    if(response.isSuccess){
      cancelledTaskListModel=TaskListByStatusModel.fromJson(response.responseData!);
    }
    else{
      showSnackBarMessage(context, response.errorMessage);
    }
    _getCancelledTaskListInProgress=false;
    setState(() {});
    

  }

}







