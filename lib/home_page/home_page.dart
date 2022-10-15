// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_is_empty, must_be_immutable

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

int currentVerticalPageIndex = 0;
bool isHandDown = false;

class _HomePageState extends State<HomePage> {
  double animPercentage = 0;
  late PageController _pageViewController;
  late Offset touchPos;

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
              }, child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
        onVerticalDragDown: (details) {
        if (_pageViewController.page != 1) return;

        touchPos = details.localPosition;
        },
        onVerticalDragUpdate: (details) {
        if (_pageViewController.page != 1) return;

        var delta = (details.localPosition - touchPos);
        setState(() {
        isHandDown = true;
        animPercentage =
        delta.dy / MediaQuery.of(context).size.height * 1.5;
        animPercentage = animPercentage.clamp(-1, 1);
        });
        },
        onVerticalDragEnd: (details) {
        if (_pageViewController.page != 1) return;

        if (animPercentage >= 0.2 && currentVerticalPageIndex < 1) {
        setState(() {
        currentVerticalPageIndex++;
        });
        }
        if (animPercentage <= -0.2 && (currentVerticalPageIndex > -1)) {
        setState(() {
        currentVerticalPageIndex--;
        });
        }

        setState(() {
        isHandDown = false;
        animPercentage = 0;
        });

        checkHomePanelAnimationWidgetCallbacks.broadcast();
        },
        child: Stack(
        children: [
        Image(
        image: AssetImage(currentTheme.backgroundImagePath),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
        ),
        PageView(controller: _pageViewController, children: [
        const WidgetsPanel(),
        HomePanelAnimationWidget(
        verticalPageIndex: 0,
        axis: 0,
        animPercantage: animPercentage,
        panel: const HomePanel())
        ]),
        HomePanelAnimationWidget(
        verticalPageIndex: 1,
        axis: -1,
        animPercantage: animPercentage,
        panel: const SearchPanel(),
        onSelected: () {
        searchBarFocusNode.requestFocus();
        },
        onDeselected: () {
        searchBarFocusNode.unfocus();
        },
        ),
        HomePanelAnimationWidget(
        verticalPageIndex: -1,
        axis: 1,
        animPercantage: animPercentage,
        panel: const AppsPanel())
        ],
        ),
        ),
        )
          );}
      },
    );
  }
}
