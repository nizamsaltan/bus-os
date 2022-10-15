// ignore_for_file: must_be_immutable

import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/design/text_sytles.dart';
import 'package:productivity_launcher/design/themes.dart';
import 'package:productivity_launcher/home_page/dock.dart';
import 'package:productivity_launcher/utils/app.dart';

TextEditingController searchPanelSearchController = TextEditingController();
late FocusNode searchBarFocusNode;

class SearchPanel extends StatefulWidget {
  const SearchPanel({Key? key}) : super(key: key);

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  @override
  void initState() {
    super.initState();

    searchBarFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    searchBarFocusNode.dispose();

    super.dispose();
  }

  void searchBarSearhApps(String query) {
    final suggestions = apps.where((app) {
      final appname = app.appName.toLowerCase();
      final input = query.toLowerCase();

      return appname.contains(input);
    }).toList();

    setState(() {
      searchApps = suggestions;
    });
  }

  void openSearchPanelApps(String query) {
    searchApps.first.openApp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            const SizedBox(height: 25),
            CupertinoTextField(
              controller: searchPanelSearchController,
              focusNode: searchBarFocusNode,
              onSubmitted: openSearchPanelApps,
              onChanged: searchBarSearhApps,
              //
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              placeholder: 'Search',
              placeholderStyle:
                  standardTextStyle.copyWith(color: Colors.black38),
              style: standardTextStyle.copyWith(color: Colors.black),
              cursorColor: currentTheme.secondaryBackgroundColor,
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.separated(
                  itemCount: searchApps.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int position) {
                    return SearchPanelAppTile(app: searchApps[position]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10)),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPanelAppTile extends StatefulWidget {
  Application app;

  SearchPanelAppTile({Key? key, required this.app}) : super(key: key);

  @override
  State<SearchPanelAppTile> createState() => _SearchPanelAppTileState();
}

class _SearchPanelAppTileState extends State<SearchPanelAppTile> {
  bool showAppDetails = false;
  final animDuration = const Duration(milliseconds: 200);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (showAppDetails) {
          setState(() {
            showAppDetails = false;
          });
        } else {
          widget.app.openApp();
        }
      },
      onLongPress: () {
        setState(() {
          showAppDetails = !showAppDetails;
        });
      },
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        height: showAppDetails ? 185 : 53,
        decoration: BoxDecoration(
            color: Colors.black45, borderRadius: BorderRadius.circular(10)),
        duration: animDuration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 37, width: 37, child: getAppIcon(widget.app)),
                  const SizedBox(width: 10),
                  Text(widget.app.appName,
                      style: standardTextStyle.copyWith(fontSize: 17)),
                ],
              ),
              Expanded(
                child: AnimatedOpacity(
                  duration: animDuration,
                  opacity: showAppDetails ? 1 : 0,
                  child: Column(
                    children: [
                      // ! Remove App
                      Expanded(
                        child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              widget.app.uninstallApp();
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline_rounded,
                                    color: standardTextStyle.color),
                                const SizedBox(width: 10),
                                Text('Remove App', style: standardTextStyle),
                              ],
                            )),
                      ),
                      // ! Add Dock
                      Expanded(
                        child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              addDockApp(widget.app);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add_circle_outline_rounded,
                                    color: standardTextStyle.color),
                                const SizedBox(width: 10),
                                Text('Add Dock', style: standardTextStyle),
                              ],
                            )),
                      ),
                      // ! App Settings
                      Expanded(
                        child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              widget.app.openSettingsScreen();
                            },
                            child: Row(
                              children: [
                                Icon(Icons.settings,
                                    color: standardTextStyle.color),
                                const SizedBox(width: 10),
                                Text('App Settings', style: standardTextStyle),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
