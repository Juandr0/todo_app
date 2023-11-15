import 'package:flutter/material.dart';

import '../image_selector/image_selector.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Selector'),
      ),
      body: const Center(
        child: Text('Press the button to choose image!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ImageSelector()),
          );
        },
        tooltip: 'Open Camera',
        child: const Icon(Icons.photo_camera),
      ),
    );
  }
}
