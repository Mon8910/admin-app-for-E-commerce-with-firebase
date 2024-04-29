import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText({
    super.key,
    required this.label,
    this.fontSize = 18,
    this.color,
    this.fontStyle,
    this.fontWeight,
    this.textDirection,
  });
  final String label;
  final double? fontSize;
  final Color? color;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
      textDirection: textDirection,
    );
  }
}
