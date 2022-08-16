import 'package:billing/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../shared/services/LocalString.dart';
import '../globals.dart' as globals;
class SolidAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double barHeight = 160.0;

  SolidAppBar({Key? key, this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight+20);

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
                height:  100,
                child: Stack(
                  children: [
                Container(
                  alignment: Alignment.topCenter,
                  // color: ColorConstants.blue,
                  height: 95,
                  child: Padding(
                    padding: const EdgeInsets.only(top:33.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        /*
                            new IconButton(
                              icon: new Icon(Icons.arrow_circle_left_outlined, size: 40),
                              onPressed: (){Get.back();},
                            ),

                             */
                        Padding(
          padding:  EdgeInsets.only(top:globals.imagePaddingTop),
          child: Container(
            //s alignment: Alignment.center,// use aligment
            child: Image.asset(globals.getLogoImage(),
              height:globals.imageHeightAppBar,
              width: globals.imageWidthAppBar,
              fit: BoxFit.fitWidth,),
          )
      ),
                        Spacer(),

                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: GestureDetector(
                            onTap: ()
                            {
                              Get.back();
                            },
                            child:

                            //Icon(FontAwesomeIcons.arrowCircleLeft,size: 40,)

                            Image.asset('images/back.png',
                                height:25, width: 25, fit: BoxFit.fitWidth),



                          )
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

        //Divider(color: ColorConstants.greenColor,thickness:2),
      ],
    );


  }
}

