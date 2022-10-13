// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:productivity_launcher/design/blur_widget.dart';
import 'package:productivity_launcher/design/text_sytles.dart';
import 'package:productivity_launcher/widgets/calculator_widget.dart';

class WidgetsPanel extends StatelessWidget {
  const WidgetsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 15),
            _weatherWidget(),
            const SizedBox(height: 15),
            const CalculatorWidget(),
          ],
        ),
      ),
    );
  }

  Widget _weatherWidget() {
    return WidgetCell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(FontAwesomeIcons.temperatureHalf,
                  color: headerTextStyle.color),
              Text('Weather', style: headerTextStyle)
            ],
          ),
          const SizedBox(height: 10),
          Text('Istanbul, Turkey',
              style: lowerTextStyle.copyWith(fontSize: 16)),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(FontAwesomeIcons.wind,
                  color: standardTextStyle.color, size: 15),
              const SizedBox(width: 5),
              Text('92%', style: lowerTextStyle),
              const SizedBox(width: 15),
              Icon(FontAwesomeIcons.cloudRain,
                  color: standardTextStyle.color, size: 15),
              const SizedBox(width: 5),
              Text('80%', style: lowerTextStyle),
              const SizedBox(width: 15),
            ],
          )
        ],
      ),
    );
  }
}

class WidgetCell extends StatelessWidget {
  Widget child;
  WidgetCell({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurWidget(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, .2),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
