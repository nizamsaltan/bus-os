// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_is_empty

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity_launcher/utils/colors.dart';
import 'package:productivity_launcher/utils/text_sytles.dart';

const taskFieldSnackBar = SnackBar(
  content: Text('Task filed is empity'),
);

const removeTaskWarningSnackBar = SnackBar(
  content: Text('To remove task, set checkboxes true'),
);

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

  List<TodoItem> items = [];

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
        body: Stack(
      children: [
        Container(color: backgroundColor),
        /*
        Image(
          image: const AssetImage("assets/images/background_2.jpeg"),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ), */ // DISABLE FOR SINGLE COLOR
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topBar(),
                  if (items.length == 0) addTodoButton() else todoPanel(),
                ]),
          ),
        ),
      ],
    ));
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

  // *** Todo Panel ***

  Widget addTodoButton() {
    return Container(
      height: 50,
      color: secondaryBackgroundColor,
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
              style: standardTextStyle.copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget todoPanel() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: shadowColor,
              blurRadius: 5.0,
              offset: const Offset(0.0, 0.75),
            )
          ],
          color: secondaryBackgroundColor),
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
                      deleteDoneTasks();
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

  Widget addNewTaskPopupDialog(BuildContext context) {
    Color primaryColor = const Color.fromARGB(255, 58, 58, 58);
    final controller = TextEditingController();
    return CupertinoAlertDialog(
      title: Text(
        'Add new task',
        style: standardTextStyle.copyWith(
          fontSize: 22,
          color: primaryColor,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          CupertinoTextField(
            controller: controller,
            placeholder: 'New task',
            style: standardTextStyle.copyWith(color: primaryColor),
          ),
        ],
      ),
      actions: <Widget>[
        CupertinoButton(
          onPressed: () {
            if (controller.text != '') {
              TodoItem item = TodoItem();
              item.text = controller.text;
              items.add(item);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(taskFieldSnackBar);
            }
            Navigator.of(context).pop();
          },
          child: Text(
            'Add',
            style: standardTextStyle.copyWith(color: primaryColor),
          ),
        ),
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: standardTextStyle.copyWith(color: primaryColor),
          ),
        ),
      ],
    );
  }

  bool isDeletedDoneTask = false;
  void deleteDoneTasks() {
    isDeletedDoneTask = false;
    for (int i = 0; i < items.length; i++) {
      if (items[i].isChecked) {
        items.remove(items[i]);
        isDeletedDoneTask = true;
      }
    }
    if (!isDeletedDoneTask) {
      ScaffoldMessenger.of(context).showSnackBar(removeTaskWarningSnackBar);
    }
  }
}

class TodoItem {
  late String text;
  bool isChecked = false;
}
