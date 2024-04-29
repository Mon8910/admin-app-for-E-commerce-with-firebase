import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget(
      {super.key, required this.pickimage, required this.fun});
  final XFile? pickimage;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: pickimage == null
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                  )
                : Image.file(File(pickimage!.path))),
        Positioned(
            right: -5,
            top: -5,
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlue,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.red,
                onTap: () {
                  fun();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.camera_alt,
                    size: 20,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
