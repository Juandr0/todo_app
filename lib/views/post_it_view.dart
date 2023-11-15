import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';

class PostItView extends StatefulWidget {
  const PostItView({this.title, this.description, this.todoImage, super.key});

  final String? title;
  final Image? todoImage;
  final String? description;

  @override
  State<StatefulWidget> createState() => _PostItViewState();
}

class _PostItViewState extends State<PostItView> {
  Size containerSize = const Size(350, 350);
  int titleMaxCharacters = 25;
  int descriptionMaxCharacters = 25;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerSize.height,
      width: containerSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.inline),
        color: Colors.yellow,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.between),
          child: Column(
            children: [
              centerTextField('Title', false, titleMaxCharacters),
              const SizedBox(height: AppSizes.between),
              centerTextField('Description', true, descriptionMaxCharacters),
              widget.todoImage == null ? iconButtons() : scalableImage()
            ],
          ),
        ),
      ),
    );
  }

  // Currently holds a placeholder image.
  Expanded scalableImage() {
    return Expanded(
      child: Image.network(
        width: double.infinity,
        fit: BoxFit.fitWidth,
        'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2021_07/2233721/171120-smile-stock-njs-333p.jpg',
      ),
    );
  }

  Row iconButtons() {
    return Row(
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

  TextField centerTextField(
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
