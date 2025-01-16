import 'package:flutter/material.dart';
import 'package:task_manager_1/data/services/network_caller.dart';
import 'package:task_manager_1/data/utils/urls.dart';
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

  bool _addNewTaskInPorgress=false;

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
                  Visibility(
                    visible: _addNewTaskInPorgress==false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          _createNewTask();
                        }
                      },
                      child: Icon(Icons.arrow_circle_right_outlined)),
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
    _addNewTaskInPorgress=true;
    setState(() {});
    Map<String, dynamic> requestBody={
      "title":_titleTEController.text.trim(),
      "description":_descriptionTEController.text.trim(),
      "status":"New"
    };
    final NetworkResponse response=await NetworkCaller.postRequest(url: Urls.createTaskUrl,body: requestBody);
    _addNewTaskInPorgress=false;
    setState(() {});
    if(response.isSuccess){
      _clearTextField();
      showSnackBarMessage(context, 'New task added!');
    }
    else{
      showSnackBarMessage(context, response.errorMessage);
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
