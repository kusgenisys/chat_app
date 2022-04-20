import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickImage) imagePickerFn;

  const UserImagePicker(this.imagePickerFn, {Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    File tempFile = File(image!.path);
    if (tempFile.path.isEmpty) {
      return;
    }
    setState(() {
      _pickedImage = File(tempFile.path);
    });
    widget.imagePickerFn(tempFile);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          if (_pickedImage == null) const CircleAvatar(
            backgroundImage: AssetImage("assets/user.png"),
            backgroundColor: Color(0xFF909CB3),
          ) else CircleAvatar(
            backgroundImage:
            _pickedImage == null ? null : FileImage(_pickedImage!),
            backgroundColor: const Color(0xFF909CB3),
          ),
          Positioned(
            right: -5,
            bottom: 2,
            child: SizedBox(
              height: 32,
              width: 32,
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                onPressed: _pickImage,
                child: const Icon(Icons.camera),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
