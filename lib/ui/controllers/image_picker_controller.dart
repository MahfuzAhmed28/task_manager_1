import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController{
  XFile? _pickedImage;
  XFile? get pickedImage=>_pickedImage;
  Future<void> pickkImage() async{

    ImagePicker picker=ImagePicker();
    XFile? image=await picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      _pickedImage=image;
      print(_pickedImage!.name);

    }
    update();
  }
}