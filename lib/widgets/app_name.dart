import 'package:admin_app/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({super.key, this.fontSize = 20});
  final int fontSize;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period:const Duration(seconds: 4),
      
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: const TitleText(
        label: 'Shop Smart',
      ),
    );
  }
}
