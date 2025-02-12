import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/data/models/task_model.dart';
import 'package:task_manager_1/ui/controllers/delete_task_controller.dart';
import 'package:task_manager_1/ui/controllers/update_task_status_controller.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/snack_bar_message.dart';


class TaskItemWidget extends StatefulWidget {
  const TaskItemWidget({
    super.key, required this.taskModel, required this.color, required this.status,
  });

  final TaskModel taskModel;
  final Color color;
  final String status;

  @override
  _TaskItemWidgetState createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {


  final TextEditingController _updateStatusTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UpdateTaskStatusController _updateTaskStatusController=Get.find<UpdateTaskStatusController>();
  final DeleteTaskController _deleteTaskController=Get.find<DeleteTaskController>();




  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(widget.taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text('Date: ${widget.taskModel.createdDate ?? ''}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: widget.color,
                  ),
                  child: Text(widget.status, style: const TextStyle(color: Colors.white)),
                ),
                Row(
                  children: [
                    GetBuilder<DeleteTaskController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.deleteTaskInProgress==false,
                          replacement: CenteredCircularProgressIndicator(),
                          child: IconButton(
                            onPressed: () {
                              _deleteTask(widget.taskModel.sId?? '');
                            },
                            icon: Icon(Icons.delete),
                          ),
                        );
                      }
                    ),
                    IconButton(
                    onPressed: () => _showUpdateDialog(context),
                    icon: Icon(Icons.edit),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Status'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _updateStatusTEController,
              decoration: InputDecoration(
                labelText: 'Enter new status',
                border: OutlineInputBorder(),
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter task status';
                }
                return null;
              },
            ),
          ),
          actions: [
            Column(
              children: [
                GetBuilder<UpdateTaskStatusController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.updateTaskStatusInProgress==false,
                      replacement: CenteredCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: _onTapUpdateStatusButton,
                        child: Text('Submit'),
                      ),
                    );
                  }
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _onTapUpdateStatusButton() {
    if (_formKey.currentState!.validate()) {
      _getUpdateTaskStatus();
    }
  }


  Future<void> _getUpdateTaskStatus() async {
    bool isSuccess=await _updateTaskStatusController.getUpdateTaskStatus(widget.taskModel.sId ?? '', _updateStatusTEController.text.trim());

    if (isSuccess) {
      Navigator.of(context).pop();
      Get.back();
      showSnackBarMessage(context, 'Status Updated');
    } else {
      showSnackBarMessage(context, _updateTaskStatusController.errorMessage!);
    }
  }

  Future<void> _deleteTask(String id) async {
    bool isSuccess=await _deleteTaskController.deleteTask(id);
    if(isSuccess){
      showSnackBarMessage(context, 'Task deleted');
    }
    else{
      showSnackBarMessage(context, _deleteTaskController.errorMessage!);
    }
  }

  @override
  void dispose(){
    _updateStatusTEController.clear();
    super.dispose();
  }
}
