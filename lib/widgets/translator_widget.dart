import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:productivity_launcher/design/text_sytles.dart';
import 'package:productivity_launcher/design/themes.dart';
import 'package:productivity_launcher/panels/widgets_panel.dart';

class TranslatorWidget extends StatefulWidget {
  const TranslatorWidget({Key? key}) : super(key: key);

  @override
  State<TranslatorWidget> createState() => _TranslatorWidgetState();
}

class _TranslatorWidgetState extends State<TranslatorWidget> {
  String _chosenValue = 'English';

  List<Language> languageList = [];
  List<String> languageDisplayNameList = [];
  List<String> languageCodeList = [];

  @override
  Widget build(BuildContext context) {
    setLanguages();
    return WidgetCell(
      name: ' Translator',
      icon: FontAwesomeIcons.language,
      content: Column(
        children: [
          DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: currentTheme.secondaryBackgroundColor,
              value: _chosenValue,
              elevation: 5,
              style: standardTextStyle,
              items: languageDisplayNameList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "Please choose a langauage",
                style: standardTextStyle,
              ),
              onChanged: onChanged),
        ],
      ),
    );
  }

  void Function(String?)? onChanged(value) {
    setState(() {
      _chosenValue = value;
    });
    return null;
  }

  void setLanguages() {
    if (languageList.isNotEmpty &&
        languageCodeList.length == languageDisplayNameList.length) {
      return;
    }
    languageList.clear();
    languageList.add(Language('English', 'en'));
    languageList.add(Language('German', 'de'));
    languageList.add(Language('Italian', 'it'));
    languageList.add(Language('Japanese', 'ja'));
    languageList.add(Language('Kurdish', 'ku'));
    languageList.add(Language('Russian', 'ru'));
    languageList.add(Language('Spanish', 'es'));
    languageList.add(Language('Turkish', 'tr'));

    languageDisplayNameList.clear();
    languageCodeList.clear();
    for (var i = 0; i < languageList.length; i++) {
      languageDisplayNameList.add(languageList[i].displayName);
      languageCodeList.add(languageList[i].code);
    }
  }
}

class Language {
  late String displayName;
  late String code;

  Language(String displayNameInput, String codeInput) {
    displayName = displayNameInput;
    code = codeInput;
  }
}
