import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/utils/text_sytles.dart';
import 'package:productivity_launcher/utils/themes.dart';

const taskFieldSnackBar = SnackBar(
  content: Text('Task filed is empity'),
);

const removeTaskWarningSnackBar = SnackBar(
  content: Text('To remove task, set checkboxes true'),
);

List<TodoItem> items = [];

class TodoItem {
  late String text;
  bool isChecked = false;
}

Widget addTodoButton(BuildContext context) {
  return Container(
    height: 50,
    color: currentTheme.secondaryBackgroundColor,
    child: CupertinoButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => addNewTaskPopupDialog(context));
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
void deleteDoneTasks(BuildContext context) {
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
