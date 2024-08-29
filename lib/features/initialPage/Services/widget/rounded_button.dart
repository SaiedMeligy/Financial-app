import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class RoundedButton extends StatelessWidget {
  final Widget title;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final IconData? icon;
  final Color color; // Updated to non-nullable
  final double fontSize;

  const RoundedButton({
    super.key,
    required this.title,
    this.fontSize = 16,
    required this.color, // Make color required
    this.height,
    this.icon,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onPressed,
      child: Container(
        width: width ?? Constants.mediaQuery.width * 0.09,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white70,width: 2),
          color: color, // Use the color parameter
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title,
            const SizedBox(width: 10),
            if (icon != null)
              Icon(
                icon,
                size: 16,
                color: Colors.white,
              ).setOnlyPadding(context, 0, 0, 0, 0.02),
          ],
        ),
      ),
    );
  }
}
