import 'dart:math' as math;

import 'package:fashion_shopping_app/shared/constants/color.dart';
import 'package:fashion_shopping_app/shared/widgets/msg/msg_arrow_painter.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';

import 'package:flutter/material.dart';

class ReceiveMsgBox extends StatelessWidget {
  final String message;
  final String? avatar;

  const ReceiveMsgBox({super.key, required this.message, this.avatar});

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
              avatar ?? 'https://reqres.in/img/faces/2-image.jpg',
            ),
          ),
          const SizedBox(width: 10),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: CustomPaint(painter: MsgArrowPainter(ColorConstants.white)),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: BaseText(message, color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 50, left: 10, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
