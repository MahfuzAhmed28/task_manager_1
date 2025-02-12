import 'package:get/get.dart';
import 'package:task_manager_1/data/models/task_model.dart';
import 'package:task_manager_1/data/models/user_model.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
import 'package:task_manager_1/ui/controllers/auth_controller.dart';

import '../../data/models/task_list_by_status_model.dart';

class CompletedTaskController extends GetxController{
  bool _inProgress=false;

  bool get inProgress=> _inProgress;
  String? _errorMessage;
  TaskListByStatusModel? _taskListByStatusModel;
  String? get errorMessage=> _errorMessage;

  List<TaskModel> get taskList=> _taskListByStatusModel?.taskList ?? [];

  Future<bool> getCompletedTaskList() async {
    bool isSucces=false;
    _inProgress=true;
    update();

    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('Completed'));

    if(response.isSuccess){
      _taskListByStatusModel=TaskListByStatusModel.fromJson(response.responseData!);
      isSucces=true;
      _errorMessage=null;
    }
    else{

      _errorMessage=response.errorMessage;


    }
    _inProgress=false;
    update();
    return isSucces;
  }
}