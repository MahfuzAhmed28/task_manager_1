import 'package:get/get.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';

class DeleteTaskController extends GetxController{
  bool _deleteTaskInProgress=false;
  bool get deleteTaskInProgress=> _deleteTaskInProgress;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;

  Future<bool> deleteTask(String id) async {
    bool isSuccess=false;
    _deleteTaskInProgress = true;
    update();

    final NetworkResponse response= await NetworkCaller.getRequest(url: Urls.deleteTaskUrl(id));

    if (response.isSuccess) {
      isSuccess=true;
      _errorMessage=null;
    } else {
      _errorMessage=response.errorMessage;
    }
    _deleteTaskInProgress = false;
    update();
    return isSuccess;
  }
}