import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FocusedMenuDetails extends StatefulWidget {
  final Offset childOffset;
  final Size childSize;
  final Widget menuContent;
  final Widget child;

  const FocusedMenuDetails({
    super.key,
    required this.menuContent,
    required this.childOffset,
    required this.childSize,
    required this.child,
  });

  @override
  State<FocusedMenuDetails> createState() => _FocusedMenuDetailsState();
}

class _FocusedMenuDetailsState extends State<FocusedMenuDetails>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _pushUpAndDownAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      vsync: this,
    )..forward();

    _pushUpAndDownAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              _controller.reverse();

              Navigator.pop(context);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 15,
            child: SlideTransition(
              position: _pushUpAndDownAnimation,
              child: _buildActions(),
            ),
          ),
          Positioned(
            top: widget.childOffset.dy,
            left: widget.childOffset.dx,
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                width: widget.childSize.width,
                height: widget.childSize.height,
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final sw = Get.width;
    final sh = Get.height;
    return Container(
      width: sw - 30,
      height: sh * .2,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(100),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: widget.menuContent,
      ),
    );
  }
}
