import 'package:get/get.dart';
import 'package:task_manager_1/data/models/task_count_by_status_model.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';

class TaskCountByStatusController extends GetxController{
  bool _taskCountByStatusInProgress=false;
  bool get taskCountByStatusInProgress=>_taskCountByStatusInProgress;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;

  TaskCountByStatusModel? _taskCountByStatusModel;
  TaskCountByStatusModel? get taskCountByStatusModel=>_taskCountByStatusModel;

  Future<bool> getTaskCountByStatus() async{
    bool isSuccess=false;
    _taskCountByStatusInProgress=true;
    update();
    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);

    if(response.isSuccess){
      _taskCountByStatusModel=TaskCountByStatusModel.fromJson(response.responseData!);
      isSuccess=true;
      _errorMessage=null;
    }
    else{
      _errorMessage=response.errorMessage;
    }
    _taskCountByStatusInProgress=false;
    update();
    return isSuccess;

  }
}