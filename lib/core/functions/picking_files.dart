import 'package:image_picker/image_picker.dart';

// pick images using ImagePicker Package
Future<List<XFile>> pickImages() async {
  final picker = ImagePicker();
  // pick multiple images
  return await picker.pickMultiImage();
}
