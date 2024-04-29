import 'package:admin_app/widgets/subtitle_test.dart';
import 'package:admin_app/widgets/title_text.dart';
import 'package:flutter/material.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.details,
    required this.textButton,
  });
  final String image;
  final String title;
  final String subTitle;
  final String details;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset(
              image,
              height: size * .35,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TitleText(
            label: title,
            fontSize: 40,
            color: Colors.red,
          ),
          const SizedBox(
            height: 20,
          ),
          SubtitleText(
            label: subTitle,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SubtitleText(
              label: details,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.red),
            child:  Text(
              textButton,
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
