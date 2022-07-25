// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_is_empty

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/home_page/top_bar.dart';
import 'package:productivity_launcher/utils/text_sytles.dart';
import 'package:productivity_launcher/utils/themes.dart';

const taskFieldSnackBar = SnackBar(
  content: Text('Task filed is empity'),
);

const removeTaskWarningSnackBar = SnackBar(
  content: Text('To remove task, set checkboxes true'),
);

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<TodoItem> items = [];
  late List<Application> apps;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: true,
          onlyAppsWithLaunchIntent: true),
      builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
        if (data.data == null) {
          return Center(
              child: CircularProgressIndicator(
            color: currentTheme.secondaryBackgroundColor,
          ));
        } else {
          apps = data.data!;
          return Scaffold(
            body: Stack(
              children: [
                if (!currentTheme.hasBackgroundImage)
                  Container(color: currentTheme.backgroundColor),
                if (currentTheme.hasBackgroundImage)
                  Image(
                    image: AssetImage(currentTheme.backgroundImagePath),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                PageView(children: [
                  homePage(),
                  appPage(),
                ]),
              ],
            ),
          );
        }
      },
    );
  }

  Widget appPage() {
    return Scrollbar(
      child: ListView.builder(
          itemBuilder: (BuildContext context, int position) {
            Application app = apps[position];
            return Column(
              children: <Widget>[
                ListTile(
                  leading: getAppIcon(app),
                  onTap: () => {app.openApp()},
                  onLongPress: () => {onAppClicked(context, app)},
                  title: Text(
                    app.appName,
                    style: standardTextStyle,
                  ), // ${app.packageName}
                  /*subtitle: Text('Version: ${app.versionName}\n'
                              'System app: ${app.systemApp}\n'
                              'APK file path: ${app.apkFilePath}\n'
                              'Data dir: ${app.dataDir}\n'
                              'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.installTimeMillis).toString()}\n'
                              'Updated: ${DateTime.fromMillisecondsSinceEpoch(app.updateTimeMillis).toString()}'), */
                ),
              ],
            );
          },
          itemCount: apps.length),
    );
  }

  Widget homePage() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              if (items.length == 0) addTodoButton() else todoPanel(),
            ]),
      ),
    );
  }

  // *** Todo Panel ***

  Widget addTodoButton() {
    return Container(
      height: 50,
      color: currentTheme.secondaryBackgroundColor,
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

  void onAppClicked(BuildContext context, Application app) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: [
                getAppIcon(app),
                const SizedBox(height: 15),
                Text(app.appName),
              ],
            ),
            actions: <Widget>[
              CupertinoButton(
                child: Text('Open app settings',
                    style: standardTextStyle.copyWith(
                        color: currentTheme.backgroundColor)),
                onPressed: () => app.openSettingsScreen(),
              ),
              CupertinoButton(
                child: Text('Uninstall app',
                    style: standardTextStyle.copyWith(
                        color: currentTheme.backgroundColor)),
                onPressed: () async => app.uninstallApp(),
              ),
            ],
          );
        });
  }
}

Widget getAppIcon(Application app) {
  if (app is ApplicationWithIcon) {
    return CircleAvatar(
      backgroundImage: MemoryImage(app.icon),
      backgroundColor: Colors.white,
    );
  } else {
    return Container();
  }
}

class TodoItem {
  late String text;
  bool isChecked = false;
}
