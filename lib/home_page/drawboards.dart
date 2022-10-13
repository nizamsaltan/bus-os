// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:productivity_launcher/design/text_sytles.dart';

class Drawboards extends StatelessWidget {
  const Drawboards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Drawboard(name: 'Social'),
        Drawboard(name: 'Creativity'),
        Drawboard(name: 'Productivitiy'),
        Drawboard(name: 'Frequently'),
      ],
    );
  }
}

// Single drawboard piece
class Drawboard extends StatefulWidget {
  late String name;
  Drawboard({Key? key, required this.name}) : super(key: key);

  @override
  State<Drawboard> createState() => _DrawboardState();
}

class _DrawboardState extends State<Drawboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: CupertinoButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          pressedOpacity: .5,
          child:
              Text(widget.name, style: headerTextStyle.copyWith(fontSize: 30)),
        ),
      ),
    );
  }
}
