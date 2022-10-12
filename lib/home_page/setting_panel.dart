import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity_launcher/utils/text_sytles.dart';

TextEditingController dockAppsTextController =
    TextEditingController(text: 'Messages,Phone,Photos,Chrome');

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({Key? key}) : super(key: key);

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text('Set dock apps',
                      style: headerTextStyle, textAlign: TextAlign.left),
                ),
                const SizedBox(height: 15),
                CupertinoTextField(controller: dockAppsTextController)
              ],
            ),
          ),
        ));
  }
}
