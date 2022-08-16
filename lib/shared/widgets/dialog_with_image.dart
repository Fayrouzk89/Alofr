import 'package:billing/modules/home/home.dart';
import 'package:billing/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../globals.dart' as globals;
import '../../routes/app_pages.dart';


class DialogWithImage extends StatelessWidget {
  final String text;
  final String imagePath;
  final String confirmText;
  DialogWithImage({
    required this.text,
    required this.imagePath,
    required this.confirmText,
  });
  @override
  Widget build(BuildContext context) {

    return Dialog(
      elevation: 0,
      backgroundColor: ColorConstants.whiteBack,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset(
                this.imagePath,
                 width: 150,
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                this.text,
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(ColorConstants.greenColor),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 25,color: ColorConstants.white))),
                  onPressed: () {
                    Navigator.of(context).pop();
                    globals.controller!.switchTab(0);
                   // globals.ho
                    Get.offAndToNamed(Routes.HOME);
                  },
                  child: Text(this.confirmText)),
            )
          ],
        ),
      ),
    );
  }
}