import 'package:admin_app/widgets/subtitle_test.dart';
import 'package:flutter/material.dart';

class MyAppMthods {
  static showErrorWringDialog({
    required BuildContext context,
    required Function fun,
    bool isError = true,
    required String title,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/warning.png',
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 15,
                ),
                SubtitleText(label: title),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const SubtitleText(
                            label: 'cancel',
                            color: Colors.green,
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          fun();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'ok',
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }

  static pickImage({
    required BuildContext context,
    required Function funCamera,
    required Function funGallery,
    required Function funRemove,
  }) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose options'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      funCamera();
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('camera'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      funGallery();
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text('Gallery'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      funRemove();
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.remove_circle),
                    label: const Text('remove'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
