import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'build_header.dart';
import '../../../globals.dart' as globals;
class TitledAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double barHeight = 170.0;

  TitledAppBar(this.title, {Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 70.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PreferredSize(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  ColorConstants.greenColor,
                  ColorConstants.greenColor
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              ),
              // color: ColorConstants.greenColor,
              child: Container(
                height: 90,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      // color: ColorConstants.blue,
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.only(top:33.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10,),

                            /*
                            new IconButton(
                              icon: new Icon(Icons.arrow_circle_left_outlined, size: 40),
                              onPressed: (){Get.back();},
                            ),

                             */
                            Container(
                              child: Image.asset(globals.getLogoImage(),
                                  height:60, width: 120, fit: BoxFit.cover),
                            ),
                            Spacer(),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: ()
                                {
                                  Get.back();
                                },
                                child: Image.asset('images/back.png',
                                    height:25, width: 25, fit: BoxFit.contain),
                              ),
                            ),


                          ],
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight )),
        BuildHeader(text: title!,),
      //  Divider(color: ColorConstants.greenColor,thickness:2),
        //Divider(color: ColorConstants.greenColor,thickness:2),
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
