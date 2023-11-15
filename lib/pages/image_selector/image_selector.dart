import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({super.key});

  @override
  State<ImageSelector> createState() {
    return _ImageSelectorState();
  }
}

class _ImageSelectorState extends State<ImageSelector> {
  File? imageFile;

  static const double containerWidth = 640;
  static const double containerHeight = 480;
  static const double borderWidth = 8;
  static const double borderRadius = 12;
  static const double fontSize = 18;
  static const double textFontSize = 26;
  static const double sizeBoxHeight = 20;
  static const double imageQuality = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturing Images'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: imageCap(),
      ),
    );
  }

  Column imageCap() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imageFile != null)
          buildImageContainer(
            image: FileImage(imageFile!),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(imageFile!),
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          buildImageContainer(
            text: 'Capture Image or Gallery?',
            decoration: BoxDecoration(
              border: Border.all(width: borderWidth, color: Colors.black12),
            ),
          ),
        const SizedBox(
          height: sizeBoxHeight,
        ),
        buttonRow(),
      ],
    );
  }

  Widget buildImageContainer({
    ImageProvider? image,
    BoxDecoration? decoration,
    String? text,
  }) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      alignment: Alignment.center,
      decoration: decoration ?? buildDefaultDecoration(),
      child: text != null
          ? Text(
              text,
              style: const TextStyle(fontSize: textFontSize),
            )
          : null,
    );
  }

  BoxDecoration buildDefaultDecoration() {
    return BoxDecoration(
      color: Colors.grey,
      border: Border.all(width: borderWidth, color: Colors.black),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  Row buttonRow() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => getImage(source: ImageSource.camera),
            child: const Text('Capture Image', style: TextStyle(fontSize: fontSize)),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () => getImage(source: ImageSource.gallery),
            child: const Text('Select Image', style: TextStyle(fontSize: fontSize)),
          ),
        ),
      ],
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
      source: source,
      maxWidth: containerWidth,
      maxHeight: containerHeight,
      imageQuality: imageQuality.toInt(), // 0 - 100
    );

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}

