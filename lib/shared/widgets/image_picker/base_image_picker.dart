import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/enums/image_source.dart';
import 'package:fashion_shopping_app/shared/helpers/notify.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BaseImagePicker extends StatelessWidget {
  final Widget child;
  final Function(XFile?) onPicked;

  const BaseImagePicker({
    super.key,
    required this.child,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          onChanged: (option) async {
            if (option == null) return;

            final ImagePicker picker = ImagePicker();
            final imageFile = await picker.pickImage(source: option);

            if (imageFile == null) return Notify.error('No image selected');

            return onPicked(imageFile);
          },
          icon: child,
          style: TextStyle(color: ColorConstants.primary),
          items: ImageSourceOptions.values
              .map((option) => DropdownMenuItem(
                    value: option.value,
                    child: Text(option.title),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
