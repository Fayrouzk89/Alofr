import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../services/LocalString.dart';
import '../custom_rounded.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double barHeight = 150.0;

  AuthAppBar({Key? key, this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 130.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreferredSize(
            child: Container(
              color: ColorConstants.greenColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center, // use aligment
                    child: Image.asset('images/title.png',
                        height: 150, width: 150, fit: BoxFit.cover),
                  )
                ],
              ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight + 80)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(

              flex: 5,
              child: Container(
                //width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: 1,
                    vertical: 5),
                child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      LocalString.getStringValue(context, 'do_buy') ??
                          "هل تريد شراء حزمة",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: CommonConstants.normalText,
                        color: ColorConstants.textColor,
                        fontFamily: CommonConstants.largeTextFont
                      ),
                    )),
                //color: Colors.red,
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                 // width: 50,
                  height: CommonConstants.roundedHeight,
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: CommonConstants.horizontalPaddingButton,
                          vertical: 5),
                      child: CustomRounded(
                        text: LocalString.getStringValue(context, 'buy') ??
                            "شراء",
                        textSize: CommonConstants.textButton,
                        textColor: Colors.white,
                        color: ColorConstants.greenColor,
                        size: Size(SizeConfig().screenWidth * 0.8,
                            CommonConstants.roundedHeight),
                        pressed: () {
                          //Get.toNamed(Routes.AUTH + Routes.REGISTER, arguments: controller);
                        },
                      ))),
            ),
          ],
        ),
         Divider(color: ColorConstants.greenColor,thickness:2),
      ],
    );
  }
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 30;
    final highPoint = size.height - 60;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
