import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/shared-preferences.dart';

class WelcomeScreen extends StatelessWidget {
  final Color buttonColor = darkGrey;
  final Color textColor = lightGrey;
  final double titleFontSize = AppSizes.titleText;
  final double subtitleFontSize = AppSizes.subtitleText;
  final double buttonFontSize = AppSizes.buttonText;
  final double paddingValue = AppSizes.between;
  final double verticalSpacing = AppSizes.between;
  final double buttonSpacing = AppSizes.between * 2;
  final BorderRadius buttonBorderRadius = BorderRadius.circular(8.0);

  WelcomeScreen({super.key});

  Widget buildTitleSection() {
    return Expanded(
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
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: verticalSpacing),
            Text(
              'Organize your tasks efficiently',
              style: TextStyle(fontSize: subtitleFontSize, color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'path',
          height: 200.0,
          width: 200.0,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10.0),
        const Text(
          'description',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildButtonSection(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              await SharedPrefHelper.setFirstTime();
              // Navigate to the Todo screen
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: buttonBorderRadius,
                ),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              child: Text(
                'Get Started',
                style: TextStyle(fontSize: buttonFontSize),
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
              style: TextStyle(fontSize: buttonFontSize, color: buttonColor),
            ),
          ),
        ],
      ),
    );
  }

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
          buildTitleSection(),
          buildImageSection(context),
          buildButtonSection(context),
        ],
      ),
    );
  }
}
