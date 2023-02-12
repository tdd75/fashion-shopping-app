import 'package:image_picker/image_picker.dart';

enum ImageSourceOptions {
  camera('Camera', ImageSource.camera),
  gallery('Gallery', ImageSource.gallery);

  final String title;
  final ImageSource value;
  const ImageSourceOptions(this.title, this.value);
}
