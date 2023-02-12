import 'package:fashion_shopping_app/shared/widgets/msg/msg_arrow_painter.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class SendMsgBox extends StatelessWidget {
  final String message;

  const SendMsgBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: Color(0XFF98E165),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: BaseText(message, color: Colors.black, fontSize: 14),
            ),
          ),
          CustomPaint(painter: MsgArrowPainter(const Color(0XFF98E165))),
          const SizedBox(width: 10),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 50, top: 15, bottom: 5),
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
