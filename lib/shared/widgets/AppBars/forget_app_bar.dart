import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../services/LocalString.dart';
import '../custom_rounded.dart';
import 'app_bar_image_logo.dart';

class ForgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBold;
  final double barHeight = 160.0;

  ForgetAppBar(this.title, this.isBold) : super();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 150.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarImageLogo(),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            color: ColorConstants.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                  child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: CommonConstants.normalText,
                            color: ColorConstants.textColor,
                            fontFamily: CommonConstants.largeTextFont,
                            fontWeight:
                                 FontWeight.bold
                               ),
                      )),
                  //color: Colors.red,
                ),
              ],
            ),
          ),
        ),
        Divider(color: ColorConstants.greenColor, thickness: 2),
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
