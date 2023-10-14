import 'package:flutter/material.dart';

class InputGroup extends StatefulWidget {
  const InputGroup({
    super.key,
    required this.labelText,
    required this.hintText,
  });

  final String labelText;
  final String hintText;

  @override
  State<InputGroup> createState() => _InputGroupState();
}

class _InputGroupState extends State<InputGroup> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.labelText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                hintText: widget.hintText,
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
