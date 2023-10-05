


import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';

class EmojiKeyboard extends StatelessWidget{


  const EmojiKeyboard({
    Key? key,
    required this.controller,
    this.emojiShowing = false,
  }):super(key: key);

  final bool emojiShowing;
  final TextEditingController controller;

  _onBackspacePressed() {
    controller
      ..text = controller.text.characters.toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Offstage(
      offstage: !emojiShowing,
      child: SizedBox(
          height: 250,
          child: EmojiPicker(
            textEditingController: controller,
            onBackspacePressed: _onBackspacePressed,
            config: Config(
              columns: 7,
              emojiSizeMax: 32 *
                  (foundation.defaultTargetPlatform ==
                      TargetPlatform.iOS
                      ? 1.30
                      : 1.0),
              initCategory: Category.RECENT,
              noRecents: const Text(
                'No Recents',
                style: TextStyle(fontSize: 20, color: Colors.black26),
                textAlign: TextAlign.center,
              ),
            ),
          )),
    );
  }

}