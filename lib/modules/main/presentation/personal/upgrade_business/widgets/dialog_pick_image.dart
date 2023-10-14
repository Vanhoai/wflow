import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DialogPickImage extends StatefulWidget {
  const DialogPickImage({super.key});

  @override
  State<DialogPickImage> createState() => _DialogPickImageState();
}

class _DialogPickImageState extends State<DialogPickImage> {
  void _pickImageFromGallery() => Navigator.pop(context, ImageSource.gallery);
  void _pickImageFromCamera() => Navigator.pop(context, ImageSource.camera);

  final RoundedRectangleBorder _roundedRectangleBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: _roundedRectangleBorder,
      content: const Text(
        'Allow Wflow choose an image',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => _pickImageFromCamera(),
          style: ElevatedButton.styleFrom(
            shape: _roundedRectangleBorder,
          ),
          child: const Text('Camera'),
        ),
        ElevatedButton(
          onPressed: () => _pickImageFromGallery(),
          style: ElevatedButton.styleFrom(
            shape: _roundedRectangleBorder,
          ),
          child: const Text('Gallery'),
        ),
      ],
    );
  }
}
