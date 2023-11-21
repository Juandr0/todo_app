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
    ImageData('assets/note.png',
        'This is the first image blabl adsadsd asdsadasdas das dada sdadas dads adad'),
    ImageData('assets/note.png', 'Second image blo sd sd adsds adsd as blo'),
    ImageData('assets/note.png',
        'Third image hohd wadawda wdawda waw dawawdaw awdawdawd awdawda wdawd wdwda wado'),
  ];

  int _selectedIndex = 0;
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
        ImageSliderIndicator(
          selectedIndex: _selectedIndex,
          itemCount: imageData.length,
        ),
        const SizedBox(
            height: 10.0), //Little space between indicator and imageslider
        SizedBox(
          height: 250.0,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemCount: imageData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    // Image
                    Container(
                      width: 200.0,
                      decoration: BoxDecoration(
                        border: _selectedIndex == index
                            ? Border.all(color: Colors.blue, width: 2.0)
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
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Text(
                            imageData[index].description,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
              // Navigate to about us?
            },
            child: Text(
              'About us',
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
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == index ? Colors.blue : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
