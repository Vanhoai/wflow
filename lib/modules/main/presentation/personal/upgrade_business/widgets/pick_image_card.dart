import 'dart:io';

import 'package:flutter/material.dart';

class PickImageCard extends StatefulWidget {
  const PickImageCard({
    super.key,
    this.image,
    required this.isImage,
    required this.pickImage,
  });

  final File? image;
  final bool isImage;
  final void Function() pickImage;

  @override
  State<PickImageCard> createState() => _PickImageCardState();
}

class _PickImageCardState extends State<PickImageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ((MediaQuery.sizeOf(context).height) / 100) * 29.42,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: widget.isImage
          ? Image.file(widget.image!)
          : Material(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200,
              child: InkWell(
                onTap: () => widget.pickImage(),
                borderRadius: BorderRadius.circular(8),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 32,
                      color: Color(0XFFABABAB),
                    ),
                    Text(
                      'Upload here',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color(0XFFB8B8B8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
