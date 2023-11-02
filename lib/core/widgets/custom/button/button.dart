import 'package:flutter/material.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/widgets/shared/shared.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.marginHorizontal = 0,
    this.marginVertical = 0,
    this.height = 50,
    this.width = double.infinity,
    this.labelStyle = const TextStyle(color: Colors.white, fontSize: 16),
  });

  final String label;
  final double marginHorizontal;
  final double marginVertical;
  final double height;
  final double width;
  final Function onPressed;
  final bool isLoading;
  final TextStyle labelStyle;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.marginHorizontal, vertical: widget.marginVertical),
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              maximumSize: const Size(double.infinity, 50),
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              animationDuration: const Duration(milliseconds: 300),
              shadowColor: AppColors.primary.withOpacity(0.5),
              elevation: 4,
            ),
            onPressed: widget.isLoading ? null : () => widget.onPressed(),
            child: Text(widget.label, style: widget.labelStyle),
          ),
          if (widget.isLoading)
            const Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: Loading(
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
