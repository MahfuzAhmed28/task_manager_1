import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/data/models/task_count_by_status_model.dart';
import 'package:task_manager_1/data/models/task_count_model.dart';
import 'package:task_manager_1/data/models/task_list_by_status_model.dart';
import 'package:task_manager_1/data/models/task_model.dart';
import 'package:task_manager_1/ui/controllers/new_task_controller.dart';
import 'package:task_manager_1/ui/controllers/task_count_by_status_controller.dart';
import 'package:task_manager_1/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_1/ui/utils/app_colors.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';
import 'package:task_manager_1/ui/widgets/snack_bar_message.dart';

import '../widgets/task_item_widget.dart';
import '../widgets/task_status_summay_widget.dart';
import '../widgets/tm_app_bar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {

  TaskCountByStatusModel? taskCountByStatusModel;
  final NewTaskController _newTaskController=Get.find<NewTaskController>();
  final TaskCountByStatusController _taskCountByStatusController=Get.find<TaskCountByStatusController>();

  @override
  void initState() {
    super.initState();
    _getTaskCountByStatus();
    _getNewTaskList();
  }

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
                child: GetBuilder<NewTaskController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress==false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: _buildTaskListView(controller.taskList),
                    );
                  }
                ),
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

  Widget _buildTaskListView(List<TaskModel> taskList) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: taskList.length,
      itemBuilder: (context,index) {
        return TaskItemWidget(
          taskModel: taskList[index],
          status: 'New',
          color: Colors.blue,
        );
      },
    );
  }

  Widget _buildTasksSummaryByStatus() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GetBuilder<TaskCountByStatusController>(
        builder: (controller) {
          return Visibility(
            visible: controller.taskCountByStatusInProgress==false,
            replacement: const CenteredCircularProgressIndicator(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  //primary: false,
                  shrinkWrap: true,
                  itemCount: taskCountByStatusModel?.taskByStatusList?.length ?? 0,
                  itemBuilder: (context,index){
                    final TaskCountModel model=taskCountByStatusModel!.taskByStatusList![index];
                    return TaskStatusSummaryCounterWidget(
                      title: model.sId ?? '',
                      count: model.sum.toString(),
                    );
                  }
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Future<void> _getTaskCountByStatus() async{
    bool isSuccess= await _taskCountByStatusController.getTaskCountByStatus();

    if(isSuccess){
      taskCountByStatusModel=_taskCountByStatusController.taskCountByStatusModel;
    }
    else{
      showSnackBarMessage(context, _taskCountByStatusController.errorMessage!);
    }
  }

  Future<void> _getNewTaskList() async{
    final bool isSuccess=await _newTaskController.getTaskList();
    if(!isSuccess){
      showSnackBarMessage(context, _newTaskController.errorMessage!);
    }
  }
}







