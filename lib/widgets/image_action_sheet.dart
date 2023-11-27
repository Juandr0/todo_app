import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

class ImageActionSheet extends StatefulWidget {
  const ImageActionSheet({super.key});

  @override
  _ImageActionSheetState createState() => _ImageActionSheetState();

  static Future<File?> show(BuildContext context) async {
    final completer = Completer<File?>();

    showAdaptiveActionSheet(
      context: context,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: const Text('Gallery'),
          onPressed: (BuildContext context) =>
              _handleImageSelection(context, ImageSource.gallery, completer),
        ),
        BottomSheetAction(
          title: const Text('Camera'),
          onPressed: (BuildContext context) =>
              _handleImageSelection(context, ImageSource.camera, completer),
        ),
      ],
      cancelAction: CancelAction(title: const Text('Cancel')),
    );

    return completer.future;
  }

  static void _handleImageSelection(BuildContext context, ImageSource source,
      Completer<File?> completer) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        completer.complete(File(pickedFile.path));
      } else {
        // User canceled image selection
        completer.complete(null);
      }
      Navigator.pop(context); // Close the action sheet
    } catch (e) {
      print('Error selecting image: $e');
      completer.complete(null);
      Navigator.pop(context); // Close the action sheet
    }
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
        child: _image == null
            ? const Text('No image selected.')
            : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedImage = await ImageActionSheet.show(context);
          if (selectedImage != null) {
            setState(() {
              _image = selectedImage;
            });
          }
        },
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
