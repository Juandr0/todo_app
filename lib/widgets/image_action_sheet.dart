import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class ImageActionSheet extends StatefulWidget {
  const ImageActionSheet({Key? key});

  @override
  _ImageActionSheetState createState() => _ImageActionSheetState();

  static Future<File?> show(BuildContext context) async {
    return showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: const Text('Photo Gallery'),
          onPressed: (context) =>
              _handleImageSelection(context, ImageSource.gallery),
        ),
        BottomSheetAction(
          title: const Text('Camera'),
          onPressed: (context) =>
              _handleImageSelection(context, ImageSource.camera),
        ),
      ],
      cancelAction: CancelAction(title: const Text('Cancel')),
    );
  }

  static Future<File?> _handleImageSelection(
      BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }
}

class _ImageActionSheetState extends State<ImageActionSheet> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Action Sheet'),
      ),
      body: Center(
        child:
            _image == null ? Text('No image selected.') : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedImage = await ImageActionSheet.show(context);
          setState(() {
            _image = selectedImage;
          });
        },
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
