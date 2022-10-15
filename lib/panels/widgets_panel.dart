// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:productivity_launcher/design/blur_widget.dart';
import 'package:productivity_launcher/design/text_sytles.dart';
import 'package:productivity_launcher/widgets/calculator_widget.dart';
import 'package:productivity_launcher/widgets/translator_widget.dart';

class WidgetsPanel extends StatelessWidget {
  const WidgetsPanel({Key? key}) : super(key: key);

  final spacer = const SizedBox(height: 15);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            spacer,
            _weatherWidget(),
            spacer,
            const CalculatorWidget(),
            spacer,
            const TranslatorWidget(),
          ],
        ),
      ),
    );
  }

  Widget _weatherWidget() {
    return WidgetCell(
      name: 'Weather',
      icon: FontAwesomeIcons.temperatureHalf,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
  String name;
  IconData icon;
  Widget content;
  WidgetCell(
      {Key? key, required this.name, required this.icon, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurWidget(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, .2),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(
                icon,
                color: standardTextStyle.color,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(name, style: headerTextStyle),
            ]),
            const SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }
}
