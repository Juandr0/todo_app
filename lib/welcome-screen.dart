import 'package:flutter/material.dart';
import 'package:todo_app/shared-preferences.dart';

class WelcomeScreen extends StatelessWidget {
  final Color buttonColor = Colors.blue;
  final Color textColor = Colors.black;
  final double titleFontSize = 36;
  final double subtitleFontSize = 18;
  final double buttonFontSize = 16;
  final double paddingValue = 20.0;
  final double verticalSpacing = 20.0;
  final double buttonSpacing = 40.0;
  final BorderRadius buttonBorderRadius = BorderRadius.circular(8.0);

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!!!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(paddingValue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to Your Todo App!',
                    style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: verticalSpacing),
                  Text(
                    'Organize your tasks efficiently',
                    style:
                        TextStyle(fontSize: subtitleFontSize, color: textColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    await SharedPrefHelper.setFirstTime();
                    // Navigate to the Todo screen
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                    child: Text(
                      'Get Started',
                      style: TextStyle(fontSize: buttonFontSize),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(buttonColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: buttonBorderRadius,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing),
                TextButton(
                  onPressed: () {
                    // Navigate to more information or tutorial screen
                  },
                  child: Text(
                    'Learn More',
                    style:
                        TextStyle(fontSize: buttonFontSize, color: buttonColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
