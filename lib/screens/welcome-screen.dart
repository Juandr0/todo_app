import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/constants/strings.dart';
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
  final BorderRadius buttonBorderRadius =
      BorderRadius.circular(AppSizes.borderRadius);

  final List<ImageData> imageData = [
    ImageData(Strings.imageOnePath, Strings.imageOneText),
    ImageData(Strings.imageTwoPath, Strings.imageTwoText),
    ImageData(Strings.imageThreePath, Strings.imageThreeText),
  ];

  int _selectedIndex = 0;

  Widget buildTitleSection() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(paddingValue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Strings.tofuName,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: verticalSpacing),
            Text(
              Strings.followSlideShow,
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
        ImageSliderIndicator(
          selectedIndex: _selectedIndex,
          itemCount: imageData.length,
        ),
        const SizedBox(
            height: AppSizes
                .within), //Little space between indicator and imageslider
        SizedBox(
          height: AppSizes.imageBoxHeight,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemCount: imageData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.borderRadius),
                child: Row(
                  children: [
                    // Image
                    Container(
                      width: AppSizes.imageBoxWidht,
                      decoration: BoxDecoration(
                        border: _selectedIndex == index
                            ? Border.all(
                                color: Colors.blue, width: AppSizes.imageBorder)
                            : null,
                      ),
                      child: ClipRect(
                        child: Image.asset(
                          imageData[index].imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Description Box
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.borderRadius),
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppSizes.borderRadius),
                        child: Center(
                          child: Text(
                            imageData[index].description,
                            style: const TextStyle(
                              fontSize: AppSizes.buttonText,
                              fontWeight: FontWeight.bold,
                              color: descriptionTextColor,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
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
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.buttonText, horizontal: AppSizes.between),
              child: Text(
                Strings.getStarted,
                style: TextStyle(fontSize: buttonFontSize),
              ),
            ),
          ),
          SizedBox(height: verticalSpacing),
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AboutUsDialog();
                  });
            },
            child: Text(
              Strings.aboutUsButton,
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
        title: const Text(Strings.welcome),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildTitleSection(),
          buildImageSlider(context),
          buildButtonSection(context),
        ],
      ),
    );
  }
}

class ImageSliderIndicator extends StatelessWidget {
  final int selectedIndex;
  final int itemCount;

  ImageSliderIndicator({required this.selectedIndex, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: AppSizes.borderRadius,
          height: AppSizes.borderRadius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == index ? selectedColor : passiveColor,
          ),
        ),
      ),
    );
  }
}

class AboutUsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.aboutUsButton),
      content: const SingleChildScrollView(
        child: Text(
          Strings.aboutUs,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
