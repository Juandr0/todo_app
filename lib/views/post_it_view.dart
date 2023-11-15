import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerSize.height,
      width: containerSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.yellow,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              centerTextField('Title', false, 25),
              const SizedBox(
                height: 20,
              ),
              centerTextField('Description', true, 75),
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
    return TextField(
      maxLines: multipleLines ? null : 1,
      maxLength: maxCharacters,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: title,
      ),
    );
  }
}
