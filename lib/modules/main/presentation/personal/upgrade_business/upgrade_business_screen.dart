import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wflow/core/theme/size.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/utils/constants.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/widgets/dialog_pick_image.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/widgets/input_group.dart';
import 'package:wflow/modules/main/presentation/personal/upgrade_business/widgets/pick_image_card.dart';

class UpgradeBusinessScreen extends StatefulWidget {
  const UpgradeBusinessScreen({super.key});

  @override
  State<UpgradeBusinessScreen> createState() => _UpgradeBusinessScreenState();
}

class _UpgradeBusinessScreenState extends State<UpgradeBusinessScreen> {
  File? _image;
  bool _isImage = false;

  void _pickImageFromGallery() => Navigator.pop(context, ImageSource.gallery);
  void _pickImageFromCamera() => Navigator.pop(context, ImageSource.camera);

  Future<void> _pickImage({required BuildContext context}) async {
    ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => DialogPickImage(
        pickImageFromCamera: () => _pickImageFromCamera(),
        pickImageFromGallery: () => _pickImageFromGallery(),
      ),
    );

    if (source != null) {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);

      setState(() {
        _image = imageTemporary;
        _isImage = !_isImage;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: AppSize.paddingScreenDefault,
            right: AppSize.paddingScreenDefault,
          ),
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Avatar for business',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              PickImageCard(
                image: _image,
                isImage: _isImage,
                pickImage: () => _pickImage(context: context),
              ),
              const SizedBox(height: 28),
              _buildInputGroup(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Fee',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '200.000 VND',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              PrimaryButton(
                onPressed: () => {},
                label: 'Upgrade',
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputGroup() {
    return Wrap(
      children: List.generate(
        inputs.length,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 28),
          child: InputGroup(
            labelText: inputs[index]['labelText'],
            hintText: inputs[index]['hintText'],
          ),
        ),
      ),
    );
  }
}
