import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../services/LocalString.dart';
import '../custom_rounded.dart';

class ForgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBold;
  final double barHeight = 160.0;

  ForgetAppBar(this.title,this.isBold) : super();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 150.0);

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
        Padding(
          padding: const EdgeInsets.only(top: 8.0,bottom: 8),
          child: Text(
           title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: CommonConstants.meduimText,
                color: ColorConstants.textColor,
                fontFamily: CommonConstants.largeTextFont,
                fontWeight: isBold!?FontWeight.bold:FontWeight.normal
            ),
          ),
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
