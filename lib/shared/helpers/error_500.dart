import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Error500 {
  static void show() {
    Get.off(
      () => const Center(
        child: Text('Something went wrong'),
      ),
    );
  }
}
