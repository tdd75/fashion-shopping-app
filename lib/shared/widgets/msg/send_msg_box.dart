import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_shopping_app/shared/widgets/msg/msg_arrow_painter.dart';
import 'package:fashion_shopping_app/shared/widgets/msg/msg_box.dart';
import 'package:fashion_shopping_app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';

class SendMsgBox extends MsgBox {
  final String message;
  const SendMsgBox(
      {Key? key, required this.message, required animationController})
      : super(key: key, animationController: animationController);

  @override
  Widget buildWidgets(BuildContext context) {
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
          CachedNetworkImage(
            width: 46,
            height: 46,
            fit: BoxFit.fill,
            imageUrl: 'https://reqres.in/img/faces/1-image.jpg',
            placeholder: (context, url) => const Image(
              image: AssetImage('assets/images/icon_success.png'),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
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
