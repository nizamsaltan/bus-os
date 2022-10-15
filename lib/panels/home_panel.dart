import 'package:flutter/material.dart';
import 'package:productivity_launcher/home_page/dock.dart';
import 'package:productivity_launcher/home_page/drawboards.dart';
import 'package:productivity_launcher/home_page/topbar.dart';

class HomePanel extends StatelessWidget {
  const HomePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: const [
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: TopBar(),
                )),
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Drawboards(),
                )),
            Align(
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
