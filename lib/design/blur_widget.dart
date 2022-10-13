// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';

class BlurWidget extends StatelessWidget {
  Widget child;
  double blurAmount;
  BlurWidget({Key? key, required this.child, this.blurAmount = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: child,
      ),
    );
  }
}
