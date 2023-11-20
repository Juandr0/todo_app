import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/shared-preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class ImageData {
  final String imagePath;
  final String description;

  ImageData(this.imagePath, this.description);
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final Color buttonColor = darkGrey;
  final Color textColor = lightGrey;
  final double titleFontSize = AppSizes.titleText;
  final double subtitleFontSize = AppSizes.subtitleText;
  final double buttonFontSize = AppSizes.buttonText;
  final double paddingValue = AppSizes.between;
  final double verticalSpacing = AppSizes.between;
  final double buttonSpacing = AppSizes.between * 2;
  final BorderRadius buttonBorderRadius = BorderRadius.circular(8.0);

  final List<ImageData> imageData = [
    ImageData('assets/note.png', 'This is the first image blabla'),
    ImageData('assets/note.png', 'Second image bloblo'),
    ImageData('assets/note.png', 'Third image hoho'),
  ];

  int _selectedIndex = -1;
  bool _showDescription = false;

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

  Widget buildImageSlider(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imageData.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 250.0,
                        width: 250.0,
                        decoration: BoxDecoration(
                          border: _selectedIndex == index
                              ? Border.all(color: Colors.blue, width: 2.0)
                              : null,
                        ),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: _selectedIndex == index ? 5.0 : 0.0,
                              sigmaY: _selectedIndex == index ? 5.0 : 0.0,
                            ),
                            child: Image.asset(
                              imageData[index].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      if (_selectedIndex == index)
                        Positioned.fill(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                imageData[index].description,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
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
          // buildTitleSection(),
          buildImageSlider(context),
          //buildButtonSection(context),
        ],
      ),
    );
  }
}
