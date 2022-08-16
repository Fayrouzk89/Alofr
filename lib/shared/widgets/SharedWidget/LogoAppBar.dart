import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';
import '../../constants/common.dart';
import '../../utils/size_config.dart';


class LogoAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
  return  new Container(
      height:180,
      decoration: new BoxDecoration(

          gradient: new LinearGradient(colors: [
            ColorConstants.greenColor,
            ColorConstants.greenColor
          ], begin: Alignment.topCenter, end: Alignment.center)),
      child:  Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          width: double.infinity,
          child: AvatarGlow(
            startDelay: Duration(milliseconds: 1000),
            glowColor: Colors.white,
            endRadius: SizeConfig().screenWidth * 0.5,
            duration: Duration(milliseconds: 3000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            child: Material(
              elevation: 8.0,
              shape: CircleBorder(),
              color: Colors.transparent,
              child: CircleAvatar(
                backgroundImage:
                AssetImage('images/logo.jpg'),
                radius:  SizeConfig().screenWidth * 0.15,
              ),
            ),
            shape: BoxShape.circle,
            animate: true,
            curve: Curves.fastOutSlowIn,
          ),
        ),
      ),
    );
  }
}