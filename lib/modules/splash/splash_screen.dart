import 'dart:io';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../shared/constants/colors.dart';
import '../../shared/constants/common.dart';
import '../../shared/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AudioCache audioCache = AudioCache();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
    playSound();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
   playSound() async{
     final file = await audioCache.loadAsFile('audio.mp3');
     final bytes = await file.readAsBytes();
     audioCache.playBytes(bytes);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: ColorConstants.lightScaffoldBackgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
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
              _textLiquidFillAnimation()
            ],
          ),
        ),

    );
  }
  Widget _textLiquidFillAnimation(){

    return Container(
      color:ColorConstants.darkScaffoldBackgroundColor,
      child:SizeAnimatedWidget(
        enabled: true,
        duration: Duration(milliseconds: 2500),
        values: [Size(100, 100),  Size(100, 150), Size(200, 150), Size(200, 200)],
        curve: Curves.fastLinearToSlowEaseIn,

        //your widget
        child: Container(
          child:Container(
            alignment: Alignment.center,// use aligment
            child: Image.asset('images/title.png',
                height: 150,
                width: SizeConfig().screenWidth * 0.5,
                fit: BoxFit.cover),
          )
        ),
      ),
    );

        /*
      Center(
        child: Image.asset('images/title.png',
            height: 150,
            width: 150,
            fit: BoxFit.cover)
          /*
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white,  fontFamily: CommonConstants.introTextFont,
            fontSize: CommonConstants.headerText),
          child:TextLiquidFill(
              text: 'الوفرة',
              waveColor:Colors.white,
              boxBackgroundColor:ColorConstants.darkScaffoldBackgroundColor,
              textStyle: TextStyle(
                fontFamily: CommonConstants.introTextFont,
                fontSize: CommonConstants.headerText,
              ),
              boxHeight: 300.0,loadUntil: 1,
              loadDuration: Duration(seconds:2),
              waveDuration: Duration(seconds:1)
          ),

           */
       // ),
      ),
    );

         */
  }

}

