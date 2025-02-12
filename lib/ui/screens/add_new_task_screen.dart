import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_1/ui/controllers/add_new_task_screen_controller.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';
import 'package:task_manager_1/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_1/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name='/add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _titleTEController=TextEditingController();
  final TextEditingController _descriptionTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  final AddNewTaskScreenController _addNewTaskScreenController=Get.find<AddNewTaskScreenController>();


  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32,),
                  Text('Add new task',style: textTheme.titleLarge,),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(
                      hintText: 'Title'
                    ),
                    validator: (String? value)
                    {
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your title here';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 6,
                    decoration: InputDecoration(
                        hintText: 'Description'
                    ),
                    validator: (String? value)
                    {
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your description here';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  GetBuilder<AddNewTaskScreenController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.addNewTaskInProgress==false,
                        replacement: const CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              _createNewTask();
                            }
                          },
                          child: Icon(Icons.arrow_circle_right_outlined)),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  Future<void> _createNewTask() async{

    String title= _titleTEController.text.trim();
    String description= _descriptionTEController.text.trim();
    bool isSuccess=await _addNewTaskScreenController.createNewTask(title, description);
    if(isSuccess){
      _clearTextField();
      showSnackBarMessage(context, 'New task added!');
    }
    else{
      showSnackBarMessage(context, _addNewTaskScreenController.errorMessage!);
    }
  }

  void _clearTextField()
  {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
