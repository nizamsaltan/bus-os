// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:productivity_launcher/design/text_sytles.dart';
import 'package:productivity_launcher/panels/widgets_panel.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({Key? key}) : super(key: key);

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  var answer = '';
  var userInput = '';
  var screenText = '0';

  // Array of button
  final List<String> buttons = [
    '7',
    '8',
    '9',
    'DEL', // 3
    'C',
    '4',
    '5',
    '6',
    '+', // 8
    'x',
    '1',
    '2',
    '3',
    '-',
    '/',
    '.',
    '0',
    '=',
    '%', // 18
    '+/-',
  ];

  @override
  Widget build(BuildContext context) {
    return WidgetCell(
      name: 'Calculator',
      icon: FontAwesomeIcons.calculator,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(screenText,
                    style: standardTextStyle.copyWith(fontSize: 28)),
              )),
          const SizedBox(height: 10),
          SizedBox(height: 185, width: 340, child: calculatorApp()),
        ],
      ),
    );
  }

  Widget calculatorApp() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: buttons.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, childAspectRatio: 1.5),
        itemBuilder: (BuildContext context, int index) {
          // Clear Button
          if (index == 4) {
            return CalculatorButton(
              onPressed: () {
                setState(() {
                  userInput = '';
                  answer = '0';
                  screenText = '0';
                });
              },
              buttonText: buttons[index],
            );
          }
          // +/- button
          else if (index == 19) {
            return CalculatorButton(
              buttonText: buttons[index],
            );
          }
          // % Button
          else if (index == 18) {
            return CalculatorButton(
              onPressed: () {
                setState(() {
                  userInput += buttons[index];
                  screenText = userInput;
                });
              },
              buttonText: buttons[index],
            );
          }
          // Delete Button
          else if (index == 3) {
            return CalculatorButton(
              onPressed: () {
                setState(() {
                  if (userInput.length > 1) {
                    userInput = userInput.substring(0, userInput.length - 1);
                    screenText = userInput;
                  } else {
                    userInput = '';
                    screenText = '0';
                  }
                });
              },
              buttonText: buttons[index],
            );
          }
          // Equal_to Button
          else if (index == 17) {
            return CalculatorButton(
              onPressed: () {
                setState(() {
                  equalPressed();
                });
              },
              buttonText: buttons[index],
            );
          }

          //  other buttons
          else {
            return CalculatorButton(
              onPressed: () {
                if (isCalcButton(buttons[index])) {
                  if (userInput.isNotEmpty) {
                    if (isCalcButton(userInput[userInput.length - 1])) {
                      setState(() {
                        userInput =
                            userInput.substring(0, userInput.length - 1);
                        userInput += buttons[index];
                        screenText = userInput;
                      });
                    } else {
                      setState(() {
                        userInput += buttons[index];
                        screenText = userInput;
                      });
                    }
                  }
                } else {
                  setState(() {
                    userInput += buttons[index];
                    screenText = userInput;
                  });
                }
              },
              buttonText: buttons[index],
            );
          }
        });
  }

  bool isCalcButton(String key) {
    if (key == 'x' ||
        key == '+' ||
        key == '-' ||
        key == '/' ||
        key == '.' ||
        key == '%') {
      return true;
    }
    return false;
  }

  // function to calculate the input operation
  void equalPressed() {
    if (userInput.isEmpty) return;

    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
    userInput = answer;
    screenText = answer;
  }
}

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final onPressed;

  const CalculatorButton({required this.buttonText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(124, 97, 97, 97),
            borderRadius: BorderRadius.circular(5),
            border:
                Border.all(color: const Color.fromARGB(255, 130, 130, 130))),
        child: TextButton(
          onPressed: onPressed,
          child: Text(buttonText,
              style: standardTextStyle.copyWith(
                  color: const Color.fromARGB(255, 255, 255, 255))),
        ),
      ),
    );
  }
}
