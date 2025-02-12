
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_1/ui/controllers/auth_controller.dart';
import 'package:task_manager_1/ui/controllers/image_picker_controller.dart';
import 'package:task_manager_1/ui/controllers/update_profile_screen_controller.dart';
import 'package:task_manager_1/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_1/ui/widgets/screen_background.dart';
import 'package:task_manager_1/ui/widgets/snack_bar_message.dart';
import 'package:task_manager_1/ui/widgets/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  static const String name='/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _mobileTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  final UpdateProfileScreenController _updateProfileScreenController=Get.find<UpdateProfileScreenController>();
  final ImagePickerController _imagePickerController=Get.find<ImagePickerController>();

  @override
  void initState() {
    super.initState();
    _emailTEController.text=AuthController.userModel?.email ?? '';
    _firstNameTEController.text=AuthController.userModel?.firstName ?? '';
    _lastNameTEController.text=AuthController.userModel?.lastName ?? '';
    _mobileTEController.text=AuthController.userModel?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      appBar:const TMAppBar(
        fromUpdateProfile: true,
      ),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32,),
                  Text(
                    'Update Profile',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 28,),
                  _buildPhotoPicker(),
                  const SizedBox(height: 8,),
                  TextFormField(
                    enabled: false,
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 28,),
                  GetBuilder<UpdateProfileScreenController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.udpadeProfileInProgress==false,
                        replacement: CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: _onTapUpdateButton,
                          child: Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _imagePickerController.pickkImage,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: Text('Photo',style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(width: 12,),
            GetBuilder<ImagePickerController>(
              builder: (controller) {
                return Text(_imagePickerController.pickedImage==null ? 'No item selected' : _imagePickerController.pickedImage!.name,maxLines: 1,);
              }
            ),
          ],
        ),
      ),
    );
  }



  void _onTapUpdateButton() {
    if(_formKey.currentState!.validate()){
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async{

    String email=_emailTEController.text.trim();
    String firstName=_firstNameTEController.text.trim();
    String lastName=_lastNameTEController.text.trim();
    String mobile=_mobileTEController.text.trim();
    XFile? pickedImage=_imagePickerController.pickedImage;
    String password=_passwordTEController.text;


    bool isSuccess= await _updateProfileScreenController.updateProfile(email, firstName, lastName, mobile, pickedImage, password);
    

    if(isSuccess){
      _passwordTEController.clear();
      showSnackBarMessage(context,'Profile Update Successfull');
    }
    else{
      showSnackBarMessage(context, _updateProfileScreenController.errorMessage!);
    }
  }

  @override
  void dispose() {
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _emailTEController.dispose();
    super.dispose();
  }
}
