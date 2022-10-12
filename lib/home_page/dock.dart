import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/app/app.dart';
import 'package:productivity_launcher/utils/themes.dart';

// **! Main Calback Widget !**

class Dock extends StatelessWidget {
  const Dock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
        width: 9999,
        height: 90,
        color: currentTheme.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: dockApps.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int position) {
                Application app = dockApps[position];
                return sampleApp(app);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 15)),
        ));
  }
}

Widget sampleApp(Application app) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.5),
      child: SizedBox(
          width: 65,
          child: InkWell(
              onTap: () {
                log('message');
                app.openApp();
              },
              child: getAppIcon(app))));
}
