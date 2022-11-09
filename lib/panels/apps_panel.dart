import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:productivity_launcher/design/themes.dart';
import 'package:productivity_launcher/utils/app_folder.dart';

import '../design/text_sytles.dart';

class AppsPanel extends StatefulWidget {
  const AppsPanel({Key? key}) : super(key: key);

  @override
  State<AppsPanel> createState() => _AppsPanelState();
}

class _AppsPanelState extends State<AppsPanel> {
  List<AppFolder> currentFolders = [];

  @override
  void initState() {
    super.initState();
    onNewFolderCreated.subscribe((args) => checkNewFolders());
    checkNewFolders();
  }

  @override
  void dispose() {
    super.dispose();
    onNewFolderCreated.unsubscribe((args) => checkNewFolders());
  }

  void checkNewFolders() {
    log('message');
    setState(() {
      currentFolders = folders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromARGB(82, 0, 0, 0),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      AppFolderManager.instance.removeFolder(currentFolders[0]);
                    },
                    child: Text('Delete Folder 0', style: standardTextStyle)),
                TextButton(
                    onPressed: () {
                      AppFolderManager.instance.addNewFolder(
                          'Folder 1', Icons.accessibility_new_sharp);
                    },
                    child: Text('Add new folder', style: standardTextStyle)),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: currentTheme.secondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: currentFolders.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return _folder(currentFolders[index]);
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _folder(AppFolder folder) {
    return TextButton(onPressed: () {}, child: Icon(folder.folderIcon));
  }
}
