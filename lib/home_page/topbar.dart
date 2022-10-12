// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_launcher/utils/text_sytles.dart';

class TopBar extends StatefulWidget {
  final Duration updateDuration;

  const TopBar({this.updateDuration = const Duration(seconds: 1)});

  static DateTime getSystemTime() {
    return DateTime.now();
  }

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  // ignore: unused_field
  late Timer _timer;
  late DateTime dateTime;

  DateFormat dayFormat = DateFormat('EEEE');
  DateFormat monthFormat = DateFormat('MMMM');

  late String todayName = dayFormat.format(dateTime);
  late String monthName = monthFormat.format(dateTime);

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    _timer = Timer.periodic(widget.updateDuration, setTime);
  }

  void setTime(Timer timer) {
    if (mounted) {
      setState(() {
        dateTime = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${dateTime.hour}:${dateTime.minute}',
            style: standardTextStyle.copyWith(fontSize: 55),
          ),
          /*
          Text(
            '${dateTime.hour}:${dateTime.minute}:${dateTime.second}',
            style: headerTextStyle.copyWith(fontSize: 45),
          ),
          const SizedBox(height: 3),
          Text(
            '  $todayName, ${dateTime.day} $monthName',
            style: lowerTextStyle.copyWith(fontSize: 17),
          ),
          const SizedBox(height: 30),
          */
        ],
      ),
    );
  }
}
