// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_is_empty, must_be_immutable

import 'dart:developer';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/app/app.dart';
import 'package:productivity_launcher/home_page/dock.dart';
import 'package:productivity_launcher/home_page/drawboards.dart';
import 'package:productivity_launcher/home_page/search_panel.dart';
import 'package:productivity_launcher/home_page/topbar.dart';
import 'package:productivity_launcher/utils/themes.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late double searchPanelOpacity = 1;
  late double searchPanelTop = -MediaQuery.of(context).size.height;
  static const Duration searchPanelDuration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: true,
          onlyAppsWithLaunchIntent: true),
      builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
        if (data.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          apps = data.data!;
          searchApps = apps;
          // FIXME: Test
          dockApps = <Application>[
            apps[1],
            apps[2],
            apps[3],
            apps[4],
          ];
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dy > 15) {
                    log('down');
                    setState(() {
                      searchPanelOpacity = 1;
                      searchPanelTop = 0;
                      searchBarFocusNode.requestFocus();
                    });
                  }
                  if (details.delta.dy < -15) {
                    log('Up');
                    setState(() {
                      searchPanelOpacity = 0;
                      searchPanelTop = -MediaQuery.of(context).size.height;
                      searchBarFocusNode.unfocus();
                    });
                  }
                },
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage(currentTheme.backgroundImagePath),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                    homePage(),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 400),
                      top: searchPanelTop,
                      child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: searchPanelOpacity,
                          child: const SearchPanel()),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget homePage() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 60),
              const TopBar(),
              const SizedBox(height: 40),
              //appManager(),
              drawboards(),
            ]),
            const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Dock(),
                ))
          ],
        ),
      ),
    );
  }
}
