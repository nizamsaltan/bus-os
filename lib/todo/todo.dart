// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/utils/text_sytles.dart';
import 'package:productivity_launcher/utils/themes.dart';

// ** Widgets **
Widget addTodoButton() {
  return Container(
      height: 50,
      decoration: BoxDecoration(
        color: currentTheme.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(defaultCurvature),
      ),
      child: CupertinoTextField(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
        style: standardTextStyle,
        decoration: BoxDecoration(
            color: currentTheme.secondaryBackgroundColor,
            borderRadius: BorderRadius.circular(defaultCurvature)),
        placeholder: 'Add new',
        placeholderStyle: standardTextStyle.copyWith(
            color: const Color.fromARGB(150, 255, 255, 255)),
      ));
}

Widget todoPanel() {
  return Column(
    children: [
      ToDoBox(text: 'text'),
      const SizedBox(height: 10),
      ToDoBox(text: 'text2'),
      const SizedBox(height: 10),
    ],
  );
}

// ** Functions **

const double defaultCurvature = 14.0;

class TodoItem {
  late String text;
  bool isChecked = false;
}

class ToDoBox extends StatefulWidget {
  String text;
  ToDoBox({Key? key, required this.text}) : super(key: key);

  @override
  State<ToDoBox> createState() => _ToDoBoxState();
}

class _ToDoBoxState extends State<ToDoBox> {
  late bool value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 999,
      decoration: BoxDecoration(
        color: currentTheme.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(defaultCurvature),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Checkbox(
              value: value,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              onChanged: (bool? changeValue) {
                setState(() {
                  value = changeValue!;
                  log('Value: $value');
                  //log('Change Value: $changeValue');
                });
              },
            ),
            Text(widget.text, style: standardTextStyle),
          ],
        ),
      ),
    );
  }
}


// *** OLD ***

  /*

  Widget todoPanel() {
    return Column(
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

  // ** End Todo Panel **

  */