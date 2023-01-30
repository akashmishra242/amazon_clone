import 'package:amazon_clone/constants/global_app_constants.dart';
import 'package:flutter/material.dart';

class CustomContainerButton extends StatelessWidget {
  final BuildContext cnxt;
  final String text;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final double? radius;
  final double? height;
  final double? width;

  const CustomContainerButton(
      {super.key,
      required this.cnxt,
      required this.text,
      this.color,
      this.borderColor,
      this.borderWidth,
      this.onTap,
      this.radius,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(cnxt).size;
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: height ?? 45,
          width: width ?? size.width * 0.45,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color ?? GlobalVariables.backgroundColor,
            border: Border.all(
                color: borderColor ?? GlobalVariables.greyBackgroundCOlor,
                width: borderWidth ?? 2.0),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 20)),
          ),
          child: Text(
            text,
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ));
  }
}
