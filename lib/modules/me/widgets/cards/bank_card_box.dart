import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankCardBox extends StatelessWidget {
  const BankCardBox({
    super.key,
    required this.cardType,
    required this.cardNum,
  });

  final String? cardType;
  final String? cardNum;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        cardType == 'VISA'
            ? Image.asset('assets/images/card_visa.png')
            : Image.asset('assets/images/card_master.png'),
        Positioned(
          width: Get.width,
          bottom: Get.width * 0.1,
          child: Text(
            '••••    ••••    ••••    $cardNum',
            // ignore: prefer_const_constructors
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
