import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/app/app.dart';
import 'package:productivity_launcher/utils/text_sytles.dart';
import 'package:productivity_launcher/utils/themes.dart';

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
    return BlurryContainer(
      borderRadius: BorderRadius.zero,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: currentTheme.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                placeholder: 'Search',
                placeholderStyle:
                    standardTextStyle.copyWith(color: Colors.black38),
                style: standardTextStyle.copyWith(color: Colors.black),
                cursorColor: currentTheme.secondaryBackgroundColor,
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: MediaQuery.of(context).size.height - 50 - 83,
                child: ListView.separated(
                    itemCount: searchApps.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int position) {
                      return appTile(searchApps[position]);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appTile(Application app) {
    return InkWell(
      onTap: () {
        app.openApp();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black45, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(height: 37, width: 37, child: getAppIcon(app)),
              const SizedBox(width: 10),
              Text(app.appName,
                  style: standardTextStyle.copyWith(fontSize: 17)),
            ],
          ),
        ),
      ),
    );
  }
}
