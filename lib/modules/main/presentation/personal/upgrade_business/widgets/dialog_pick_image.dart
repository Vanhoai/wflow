import 'package:flutter/material.dart';

class DialogPickImage extends StatefulWidget {
  const DialogPickImage({
    super.key,
    required this.pickImageFromCamera,
    required this.pickImageFromGallery,
  });

  final void Function()? pickImageFromCamera;
  final void Function()? pickImageFromGallery;

  @override
  State<DialogPickImage> createState() => _DialogPickImageState();
}

class _DialogPickImageState extends State<DialogPickImage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
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
          onPressed: widget.pickImageFromCamera,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Camera'),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: widget.pickImageFromGallery,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Gallery'),
        ),
      ],
    );
  }
}
