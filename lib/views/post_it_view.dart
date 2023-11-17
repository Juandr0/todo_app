import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/models/to_do.dart';
import 'package:todo_app/widgets/color_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class PostItView extends StatefulWidget {
  const PostItView({required this.todoItem, super.key});

  final Todo todoItem;

  @override
  State<StatefulWidget> createState() => _PostItViewState();
}

class _PostItViewState extends State<PostItView> {
  int titleMaxCharacters = 25;
  int descriptionMaxCharacters = 70;
  Color backgroundColor = const Color.fromARGB(255, 255, 255, 0);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.todoItem.title;
    descriptionController.text = widget.todoItem.description ?? "";

    var todoFields = [
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
      widget.todoItem.image == null ? _iconButton() : _imageStack(),
    ];
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.inline),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.between),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Column(children: todoFields),
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.within),
              child: ColorPicker(changeBackground: changeBackgroundColor),
            ),
          ]),
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

  void changeBackgroundColor(Color newColor) {
    setState(() {
      backgroundColor = newColor;
    });
  }

  TextButton _textButton(String text) {
    return TextButton(
      onPressed: () => {
        if (text == 'OK')
          {
            // Save instance of Todo item.
          },
        Navigator.pop(context, text),
      },
      child: Text(text),
    );
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
              setState(() {
                widget.todoItem.image = null;
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
        fit: BoxFit.fitWidth,
        'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2021_07/2233721/171120-smile-stock-njs-333p.jpg',
      ),
    );
  }

  DottedBorder _iconButton() {
    return DottedBorder(
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.camera_alt,
            color: Colors.black,
          ),
          label: const Text(
            'Add image',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
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
