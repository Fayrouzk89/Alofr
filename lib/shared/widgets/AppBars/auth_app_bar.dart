import 'package:billing/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../services/LocalString.dart';
import '../../services/MessageHelper.dart';
import '../custom_rounded.dart';
import 'app_bar_image_logo.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? title2;
  final double barHeight = 150.0;

  AuthAppBar({Key? key,required this.title,required this.title2}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 160.0);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: SizeConfig().screenWidth-120,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: 1,
                      vertical:10),
                  child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: CommonConstants.normalText,
                            color: ColorConstants.textColor,
                            fontFamily: CommonConstants.largeTextFont
                        ),
                      )),
                  //color: Colors.red,
                ),

                Container(
                  child: Container(
                     width:100,
                      height: CommonConstants.roundedHeight,
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 5),
                          child: CustomRounded(
                            text:title2!,
                            textSize: CommonConstants.textApp,
                            textColor: Colors.white,
                            color: ColorConstants.greenColor,
                            size: Size(SizeConfig().screenWidth * 0.8,
                                CommonConstants.roundedHeight),
                            pressed: () {
                             validate(context);

                              //Get.toNamed(Routes.AUTH + Routes.REGISTER, arguments: controller);
                            },
                          )
                      )),
                ),
              ],
            ),
          ),
        ),
        Divider(color: ColorConstants.greenColor,thickness:2),
      ],
    );
  }
  void validate(BuildContext context)async
  {
    //await Future.delayed(Duration(milliseconds: 3000));
    var storage = Get.find<SharedPreferences>();
    try {
      if (storage.getString(StorageConstants.accessToken) != null && storage.getString(StorageConstants.accessToken) != '' ) {
        Get.toNamed(Routes.buy);
      } else {
        Get.toNamed(Routes.defaultPackages);
        /*
        MessageHelper.showMessage(context,LocalString.getStringValue(
            context, 'you_must_login') ??
            'يجب تسجيل الدخول');

         */

      }
    } catch (e) {

    }
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
