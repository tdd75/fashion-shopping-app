import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PreviewImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;

  const PreviewImage(this.url, {super.key, this.fit = BoxFit.fitHeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => PhotoView(imageProvider: NetworkImage(url))),
      child: Image.network(url, fit: fit),
    );
  }
}
