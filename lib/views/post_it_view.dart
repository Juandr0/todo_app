import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:todo_app/models/to_do.dart';
import 'package:todo_app/widgets/color_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:todo_app/widgets/image_action_sheet.dart';

enum InputType { title, description }

class PostItView extends StatefulWidget {
  const PostItView({required this.todoItem, super.key});

  final Todo todoItem;

  @override
  State<StatefulWidget> createState() => _PostItViewState();
}

class _PostItViewState extends State<PostItView> {
  int titleMaxCharacters = 25;
  int descriptionMaxCharacters = 70;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.todoItem.title;
    descriptionController.text = widget.todoItem.description ?? "";

    var todoFields = [
      _centerTextField(
          'Title', false, titleMaxCharacters, titleController, InputType.title),
      const SizedBox(height: AppSizes.between),
      _centerTextField('Description', true, descriptionMaxCharacters,
          descriptionController, InputType.description),
      const SizedBox(height: AppSizes.within),
      widget.todoItem.image == null ? _iconButton() : _imageStack(),
    ];
    return Column(
      children: [
        Card(
          color: widget.todoItem.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.inline),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.between),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Column(children: todoFields),
              ]),
            ),
          ),
        ),
        ColorPicker(widget.todoItem.backgroundColor,
            changeBackground: changeBackgroundColor),
      ],
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
      widget.todoItem.backgroundColor = newColor;
    });
  }

  Stack _imageStack() {
    return Stack(
      children: [
        _scalableImage(widget.todoItem.image!),
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

  SizedBox _scalableImage(Image? image) {
    return SizedBox(
      child: image ?? const SizedBox.shrink(),
    );
  }

  DottedBorder _iconButton() {
    return DottedBorder(
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          onPressed: () async {
            final selectedImage = await ImageActionSheet.show(context);
            if (selectedImage != null) {
              setState(() {
                widget.todoItem.image = Image.file(selectedImage);
              });
            }
          },
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

  TextField _centerTextField(String title, bool multipleLines,
      int maxCharacters, textFieldController, InputType inputType) {
    int defaultAmount = 1;

    return TextField(
        controller: textFieldController,
        maxLines: multipleLines ? null : defaultAmount,
        maxLength: maxCharacters,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: title,
        ),
        onChanged: (title) {
          setState(() {
            if (inputType == InputType.title) {
              widget.todoItem.title = title;
            } else {
              widget.todoItem.description = title;
            }
          });
        });
  }
}
