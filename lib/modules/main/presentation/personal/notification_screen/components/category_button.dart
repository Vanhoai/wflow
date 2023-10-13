import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  const CategoryButton({
    super.key,
    required this.category,
    required this.isActive,
    required this.onChanged,
  });

  final String category;
  final bool isActive;
  final Function()? onChanged;

  @override
  State<CategoryButton> createState() => Category_Button();
}

class Category_Button extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      child: SizedBox(
        height: 33,
        child: OutlinedButton(
          onPressed: widget.onChanged,
          style: OutlinedButton.styleFrom(
            backgroundColor:
                widget.isActive ? const Color(0XFF1E88E5) : Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            side: BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: widget.isActive
                  ? const Color(0XFF1E88E5)
                  : const Color(0XFFD6D6D6),
            ),
          ),
          child: Text(
            widget.category,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: widget.isActive ? Colors.white : const Color(0XFF606060),
            ),
          ),
        ),
      ),
    );
  }
}
