import 'package:get/get.dart';
import 'package:task_manager_1/ui/controllers/add_new_task_screen_controller.dart';
import 'package:task_manager_1/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager_1/ui/controllers/completed_task_controller.dart';
import 'package:task_manager_1/ui/controllers/delete_task_controller.dart';
import 'package:task_manager_1/ui/controllers/forgot_password_verify_email_screen_controller.dart';
import 'package:task_manager_1/ui/controllers/forgot_password_verify_otp_screen_controller.dart';
import 'package:task_manager_1/ui/controllers/image_picker_controller.dart';
import 'package:task_manager_1/ui/controllers/new_task_controller.dart';
import 'package:task_manager_1/ui/controllers/progress_task_controller.dart';
import 'package:task_manager_1/ui/controllers/resset_password_screen_controller.dart';
import 'package:task_manager_1/ui/controllers/sign_in_controller.dart';
import 'package:task_manager_1/ui/controllers/sign_up_controller.dart';
import 'package:task_manager_1/ui/controllers/task_count_by_status_controller.dart';
import 'package:task_manager_1/ui/controllers/update_profile_screen_controller.dart';
import 'package:task_manager_1/ui/controllers/update_task_status_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.put(NewTaskController());
    Get.put(TaskCountByStatusController());
    Get.put(ProgressTaskController());
    Get.put(CompletedTaskController());
    Get.put(CancelledTaskController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => UpdateProfileScreenController());
    Get.lazyPut(() => AddNewTaskScreenController());
    Get.lazyPut(() => ForgotPasswordVerifyEmailScreenController());
    Get.lazyPut(() => ForgotPasswordVerifyOTPScreenController());
    Get.lazyPut(() => RessetPasswordScreenController());
    Get.lazyPut(() => UpdateTaskStatusController());
    Get.lazyPut(() => DeleteTaskController());
    Get.lazyPut(() => ImagePickerController());
  }

}