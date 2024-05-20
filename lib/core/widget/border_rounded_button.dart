
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class BorderRoundedButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final IconData? icon;
  final Color? color;
  final double fontSize;

  const BorderRoundedButton({
    super.key,
    required this.title,
    this.fontSize = 16,
    this.color,
    this.height,
    this.icon,
    this.onPressed,
    this.width,
  });

  Widget borderRoundedButton(
      BuildContext context,
      ) {
    var theme = Theme.of(context);
    return Bounceable(
      onTap: onPressed,
      child: Container(
        width: Constants.mediaQuery.width*0.09,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          // border: Border.all(color: color ?? Colors.black, width: 1),
          borderRadius: BorderRadius.circular(15),
          color: Constants.theme.primaryColor.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 2,
              style: Constants.theme.textTheme.titleLarge?.copyWith(
                color: Colors.black
              ),
            ),
            const SizedBox(width: 10),
            if (icon != null)
              Icon(
                icon,
                size: 16,
                color: color ?? Colors.black,
              ).setOnlyPadding(context, 0, 0, 0, 0.02),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return borderRoundedButton(context);
  }
}