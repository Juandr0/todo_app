import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/shared_preferences.dart';
import 'package:todo_app/models/image_data.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  final Color buttonColor = AppColors.darkGrey;
  final Color textColor = AppColors.darkGrey;

  final List<ImageData> imageData = [
    ImageData(Strings.imageOnePath, Strings.imageOneText),
    ImageData(Strings.imageTwoPath, Strings.imageTwoText),
    ImageData(Strings.imageThreePath, Strings.imageThreeText),
    ImageData(Strings.imageFourPath, Strings.imageFourText)
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  Future<void> checkFirstTime() async {
    bool isFirstTime = await SharedPrefHelper.isFirstTime();
    if (isFirstTime) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  Widget buildTitleSection() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.between),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Strings.tofuName,
              style: TextStyle(
                fontSize: AppSizes.within * 3.2,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.between),
            Text(
              Strings.followSlideShow,
              style:
                  TextStyle(fontSize: AppSizes.within * 1.8, color: textColor),
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
          height: AppSizes.within * 25,
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
                    horizontal: AppSizes.within * 0.8),
                child: Row(
                  children: [
                    // Image
                    Container(
                      width: AppSizes.within * 20,
                      decoration: BoxDecoration(
                        border: _selectedIndex == index
                            ? Border.all(
                                color: Colors.blue, width: AppSizes.inlineText)
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
                        padding: const EdgeInsets.all(AppSizes.within * 0.8),
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppSizes.inlineText),
                        child: Center(
                          child: Text(
                            imageData[index].description,
                            style: const TextStyle(
                              fontSize: AppSizes.within * 1.6,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGrey,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 12,
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
              checkFirstTime();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.within * 0.8),
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.within * 1.6,
                  horizontal: AppSizes.between),
              child: Text(
                Strings.getStarted,
                style: TextStyle(fontSize: AppSizes.within * 1.8),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.between),
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AboutUsDialog();
                  });
            },
            child: Text(
              Strings.aboutUsButton,
              style: TextStyle(
                  fontSize: AppSizes.within * 1.8, color: buttonColor),
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

  const ImageSliderIndicator(
      {super.key, required this.selectedIndex, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: AppSizes.within * 0.8,
          height: AppSizes.within * 0.8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                selectedIndex == index ? AppColors.active : AppColors.inactive,
          ),
        ),
      ),
    );
  }
}

class AboutUsDialog extends StatelessWidget {
  const AboutUsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Strings.aboutUsButton),
      content: const SingleChildScrollView(
        child: Text(
          Strings.aboutUs,
          style: TextStyle(fontSize: AppSizes.within * 1.8),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
