// ignore_for_file: must_be_immutable

import 'package:event/event.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/home_page/home_page.dart';

var checkHomePanelAnimationWidgetCallbacks = Event();

class HomePanelAnimationWidget extends StatefulWidget {
  double animPercantage;
  int verticalPageIndex;
  int axis;
  Widget panel;

  void Function()? onSelected;
  void Function()? onDeselected;

  HomePanelAnimationWidget(
      {Key? key,
      required this.verticalPageIndex,
      required this.axis,
      required this.animPercantage,
      required this.panel,
      this.onSelected,
      this.onDeselected})
      : super(key: key);

  @override
  State<HomePanelAnimationWidget> createState() =>
      _HomePanelAnimationWidgetState();
}

class _HomePanelAnimationWidgetState extends State<HomePanelAnimationWidget> {
  final int animationDuration = 300; // Miliseconds

  @override
  void initState() {
    super.initState();
    checkHomePanelAnimationWidgetCallbacks.subscribe((args) {checkCallbacks(); });
  }

  void checkCallbacks() {
    print('object');
    if (currentVerticalPageIndex == widget.verticalPageIndex) {
      widget.onSelected?.call();
    }
    if (currentVerticalPageIndex != widget.verticalPageIndex) {
      widget.onDeselected?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: (isHandDown ? 0 : animationDuration)),
      opacity: (currentVerticalPageIndex == widget.verticalPageIndex &&
              !isHandDown)
          ? 1
          : (currentVerticalPageIndex == widget.verticalPageIndex && isHandDown)
              ? (1 - widget.animPercantage.abs())
              : widget.animPercantage.abs(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: (isHandDown ? 0 : animationDuration)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        transform: (currentVerticalPageIndex == widget.verticalPageIndex &&
                !isHandDown)
            ? Matrix4.translationValues(0, 0, 0)
            : Matrix4.translationValues(
                0,
                (MediaQuery.of(context).size.height *
                        ((currentVerticalPageIndex == widget.verticalPageIndex)
                            ? widget.animPercantage.abs()
                            : (currentVerticalPageIndex == 0 &&
                                    widget.animPercantage.isNegative ==
                                        widget.verticalPageIndex.isNegative)
                                ? 1 - widget.animPercantage.abs()
                                : 1)) *
                    widget.axis,
                0),
        child: widget.panel,
      ),
    );
  }
}
