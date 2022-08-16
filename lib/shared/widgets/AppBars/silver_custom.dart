import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../services/LocalString.dart';
import 'build_header.dart';
import '../../../globals.dart' as globals;
class SilverAppBarCustom extends StatelessWidget {
  final String title;
  SilverAppBarCustom({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   SliverAppBar(
      pinned: true,
      leadingWidth: 0,
      leading: Text(''),
      expandedHeight: globals.silver_expanded_height,
      toolbarHeight:  globals.silver_tool_height,
      titleSpacing: 0,
      actions: <Widget>[
        IconButton(
          icon:  Image.asset("images/back.png"),
          onPressed: () {
            Get.back();
          },
        ),
      ],
      title: Padding(
          padding:  EdgeInsets.only(top:globals.imagePaddingTop),
          child: Container(
            //s alignment: Alignment.center,// use aligment
            child: Image.asset(globals.getLogoImage(),
              height:globals.imageHeightAppBar,
              width: globals.imageWidthAppBar,
              fit: BoxFit.fitWidth,),
          )
      ),
      bottom:  PreferredSize(
        preferredSize:  Size.fromHeight(kToolbarHeight ),
        child: Container(
          color: ColorConstants.greyBack,
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child:
            BuildHeader(text: title ,)
            ,
          ),
        ),
      ),

      backgroundColor: ColorConstants.greenColor,

    );
      /*
      SliverAppBar(
      pinned: true,
      expandedHeight: 55,
      toolbarHeight: 55,
      titleSpacing: 0,
      actions: <Widget>[
        IconButton(
          icon:  Image.asset('images/back.png'),
          onPressed: () {
          Get.back();
          },
        ),
      ],
      leadingWidth: 0,

      automaticallyImplyLeading: false,
      title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Container(
            //s alignment: Alignment.center,// use aligment
            child: Image.asset('images/title.png',
              height:44,
              width: 130,
              fit: BoxFit.fitWidth,),
          )
      ),
      bottom:  PreferredSize(
        preferredSize:  Size.fromHeight(kToolbarHeight ),
        child: Container(
          color: ColorConstants.greyBack,
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child:
            BuildHeader(text: title ,)

            ,
          ),
        ),
      ),

      backgroundColor: ColorConstants.greenColor,

    );

       */
  }
}
