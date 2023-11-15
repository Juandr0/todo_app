import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/models/to_do.dart';

class PostItView extends StatefulWidget {
  const PostItView({required this.todoItem, super.key});

  final Todo todoItem;

  @override
  State<StatefulWidget> createState() => _PostItViewState();
}

class _PostItViewState extends State<PostItView> {
  Size containerSize = const Size(350, 350);
  int titleMaxCharacters = 25;
  int descriptionMaxCharacters = 75;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.todoItem.title;
    descriptionController.text = widget.todoItem.description ?? "";

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
              _centerTextField(
                'Title',
                false,
                titleMaxCharacters,
                titleController,
              ),
              const SizedBox(height: AppSizes.between),
              _centerTextField(
                'Description',
                true,
                descriptionMaxCharacters,
                descriptionController,
              ),
              const SizedBox(height: AppSizes.within),
              widget.todoItem.image == null ? _iconButtons() : _imageStack()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Stack _imageStack() {
    return Stack(
      children: [
        _scalableImage(),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            alignment: Alignment.topRight,
            onPressed: () {
              widget.todoItem.image = null;
              setState(() {
                widget.todoItem.image == null;
              });
            },
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _scalableImage() {
    return SizedBox(
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
    textFieldController,
  ) {
    int defaultAmount = 1;

    return TextField(
      controller: textFieldController,
      maxLines: multipleLines ? null : defaultAmount,
      maxLength: maxCharacters,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: title,
      ),
    );
  }
}
