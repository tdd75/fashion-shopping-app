import 'package:flutter/material.dart';

import 'package:fashion_shopping_app/core/widgets/loading/loading_circle.dart';

class LoadingOverlay {
  OverlayEntry? _overlay;

  LoadingOverlay();

  void show(BuildContext context) {
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => const LoadingCircle(),
      );
      Overlay.of(context)?.insert(_overlay!);
    }
  }

  void hide() {
    if (_overlay != null) {
      _overlay?.remove();
      _overlay = null;
    }
  }
}
