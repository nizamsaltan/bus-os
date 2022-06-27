// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_is_empty

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_launcher/app/apps_events.dart';
import 'package:productivity_launcher/app/apps_list.dart';
import 'package:productivity_launcher/todo/todo.dart';
import 'package:productivity_launcher/utils/text_sytles.dart';
import 'package:productivity_launcher/utils/themes.dart';

class HomePage extends StatefulWidget {
  final Duration updateDuration;

  const HomePage({this.updateDuration = const Duration(seconds: 1)});

  static DateTime getSystemTime() {
    return DateTime.now();
  }

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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
    setState(() {
      dateTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBackground(
        context: context,
        child: PageView(
          children: [
            // HOME
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topBar(),
                    if (items.length == 0)
                      addTodoButton(context)
                    else
                      todoPanel(context),
                  ],
                ),
              ),
            ),
            const AppsListScreen(),
            const AppsEventsScreen()
          ],
        ),
      ),
    );
  }

  Widget topBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
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
      ],
    );
  }

  Widget todoPanel(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: currentTheme.shadowColor,
              blurRadius: 5.0,
              offset: const Offset(0.0, 0.75),
            )
          ],
          color: currentTheme.secondaryBackgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ITEMS
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => Row(
                children: [
                  Checkbox(
                    checkColor: Colors.black,
                    fillColor: MaterialStateProperty.all(lowerTextStyle.color),
                    value: items[index].isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        items[index].isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    items[index].text,
                    style: standardTextStyle,
                  ),
                ],
              ),
            ),
          ),
          // LOWER PANEL
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              addNewTaskPopupDialog(context));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 5),
                        Icon(
                          CupertinoIcons.add_circled,
                          color: lowerTextStyle.color,
                        ),
                        Text(
                          '   Add new task',
                          style: lowerTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      deleteDoneTasks(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 20),
                        Icon(
                          CupertinoIcons.delete,
                          color: lowerTextStyle.color,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget getBackground({required Widget child, required BuildContext context}) {
  if (currentTheme.hasBackgroundImage) {
    return Stack(
      children: [
        Image(
          image: const AssetImage("assets/images/background_2.jpeg"),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        child,
      ],
    );
  } else {
    return Container(color: currentTheme.backgroundColor, child: child);
  }
}
