// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HomePanelAnimationWidget extends StatefulWidget {
  bool isActive;
  int axis;
  Widget panel;

  HomePanelAnimationWidget(
      {Key? key,
      required this.isActive,
      required this.panel,
      required this.axis})
      : super(key: key);

  @override
  State<HomePanelAnimationWidget> createState() =>
      _HomePanelAnimationWidgetState();
}

class _HomePanelAnimationWidgetState extends State<HomePanelAnimationWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: widget.isActive ? 1 : 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        transform: widget.isActive
            ? Matrix4.translationValues(0, 0, 0)
            : Matrix4.translationValues(
                0, MediaQuery.of(context).size.height * widget.axis, 0),
        child: widget.panel,
      ),
    );
  }
}
