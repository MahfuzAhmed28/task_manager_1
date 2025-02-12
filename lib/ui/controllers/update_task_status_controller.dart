import 'package:get/get.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';

class UpdateTaskStatusController extends GetxController{
  bool _updateTaskStatusInProgress=false;
  bool get updateTaskStatusInProgress=> _updateTaskStatusInProgress;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;

  Future<bool> getUpdateTaskStatus(String id, String status) async {
    bool isSuccess=false;
    _updateTaskStatusInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.updateTaskListStatusUrl(id ?? '', status),
    );

    if (response.isSuccess) {
      isSuccess=true;
      _errorMessage=null;
    } else {
      _errorMessage=response.errorMessage;
    }
    _updateTaskStatusInProgress = false;
    update();
    return isSuccess;
  }
}