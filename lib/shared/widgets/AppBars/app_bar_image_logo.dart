import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import '../../../globals.dart' as globals;
class AppBarImageLogo extends StatelessWidget {


  AppBarImageLogo() : super();

  @override


  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConstants.greenColor,
        height: CommonConstants.appBarHeight,
        child: Padding(
          padding:  EdgeInsets.only(top:  CommonConstants.appBarImagePaddingTop),
          child: Align(
            alignment: Alignment.center, // use aligment
            child: Container(
              child: Image.asset(globals.getLogoImage(),
                  height:  CommonConstants.appBarImageHeight, width:  CommonConstants.appBarImageWidth, fit: BoxFit.cover),
            ),
          ),
        )
    );
  }
}

