// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_is_empty, must_be_immutable

import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:productivity_launcher/design/home_panel_widget_anim.dart';
import 'package:productivity_launcher/design/themes.dart';
import 'package:productivity_launcher/home_page/dock.dart';
import 'package:productivity_launcher/panels/apps_panel.dart';
import 'package:productivity_launcher/panels/home_panel.dart';
import 'package:productivity_launcher/panels/search_panel.dart';
import 'package:productivity_launcher/panels/widgets_panel.dart';
import 'package:productivity_launcher/utils/app.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int verticalPageIndex = 0;
  bool gestureTimerCheck = false;
  int verticalPageIndicator = 0;
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: true,
          onlyAppsWithLaunchIntent: true),
      builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
        if (data.data == null) {
          return const GFLoader(type: GFLoaderType.ios);
        } else {
          apps = data.data!;
          searchApps = apps;
          setDockAppsAtStart();
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dy < -20 && !gestureTimerCheck) {
                    searchBarFocusNode.unfocus();
                    if (verticalPageIndex > -1) {
                      setState(() {
                        verticalPageIndex--;
                      });
                    }

                    gestureTimerCheck = true;
                    Timer(const Duration(seconds: 1), () {
                      gestureTimerCheck = false;
                    });
                  } else if (details.delta.dy > 20 && !gestureTimerCheck) {
                    if (verticalPageIndex < 1) {
                      setState(() {
                        verticalPageIndex++;
                      });
                    }
                    if (verticalPageIndex == 1) {
                      searchBarFocusNode.requestFocus();
                    }

                    gestureTimerCheck = true;
                    Timer(const Duration(seconds: 1), () {
                      gestureTimerCheck = false;
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
                    PageView(
                      controller: _pageViewController,
                      children: [
                        const WidgetsPanel(),
                        HomePanelAnimationWidget(
                            isActive: verticalPageIndex == 0,
                            axis: -verticalPageIndex,
                            panel: const HomePanel()),
                      ],
                    ),
                    HomePanelAnimationWidget(
                        isActive: verticalPageIndex == 1,
                        axis: -1,
                        panel: const SearchPanel()),
                    HomePanelAnimationWidget(
                        isActive: verticalPageIndex == -1,
                        axis: 1,
                        panel: const AppsPanel()),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
