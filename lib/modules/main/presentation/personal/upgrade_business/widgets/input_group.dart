import 'package:flutter/material.dart';

class InputGroup extends StatelessWidget {
  const InputGroup({
    super.key,
    required this.labelText,
    required this.hintText,
    this.maxLines = 1,
    this.minLines = 1,
    required this.editingController,
  });

  final String labelText;
  final String hintText;
  final int maxLines;
  final int minLines;
  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            labelText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            child: TextField(
              controller: editingController,
              maxLines: maxLines,
              minLines: minLines,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0XFFA5A5A5),
                ),
                filled: true,
                fillColor: const Color(0XFFEDEDED),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
