import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';

class PostItView extends StatefulWidget {
  PostItView(
      {this.title,
      this.description,
      this.todoImage,
      super.key,
      required this.backgroundColor});

  final String? title;
  final Image? todoImage;
  final String? description;
  Color backgroundColor;

  @override
  State<StatefulWidget> createState() => _PostItViewState();
}

class _PostItViewState extends State<PostItView> {
  Size containerSize = const Size(350, 350);
  int titleMaxCharacters = 25;
  int descriptionMaxCharacters = 75;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerSize.height,
      width: containerSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.inline),
        color: widget.backgroundColor,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.between),
          child: Column(
            children: [
              _centerTextField('Title', false, titleMaxCharacters),
              const SizedBox(height: AppSizes.between),
              _centerTextField('Description', true, descriptionMaxCharacters),
              const SizedBox(height: AppSizes.within),
              widget.todoImage == null ? _iconButtons() : _imageStack()
            ],
          ),
        ),
      ),
    );
  }

  // TODO: Add logic that removes image upon click. Task currently blocked
  Stack _imageStack() {
    return Stack(
      children: [
        _scalableImage(),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            alignment: Alignment.topRight,
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  // TODO: Replace placeholder image with real image. Task currently blocked
  Expanded _scalableImage() {
    return Expanded(
      child: Image.network(
        width: double.infinity,
        fit: BoxFit.fitWidth,
        'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2021_07/2233721/171120-smile-stock-njs-333p.jpg',
      ),
    );
  }

  Row _iconButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.image_outlined),
        )
      ],
    );
  }

  TextField _centerTextField(
    String title,
    bool multipleLines,
    int maxCharacters,
  ) {
    int defaultAmount = 1;

    return TextField(
      maxLines: multipleLines ? null : defaultAmount,
      maxLength: maxCharacters,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: title,
      ),
    );
  }
}
