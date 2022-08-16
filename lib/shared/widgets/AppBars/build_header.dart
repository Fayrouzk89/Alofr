import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/common.dart';
import '../../utils/size_config.dart';

class BuildHeader extends StatelessWidget {
  final String text;
  BuildHeader({
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            color: ColorConstants.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: SizeConfig().screenWidth-10,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: 1,
                      vertical:3),
                  child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        text!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: CommonConstants.appBarText,
                            color: ColorConstants.textColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: CommonConstants.largeTextFont
                        ),
                      )),
                  //color: Colors.red,
                ),
              ],
            ),
          ),
        ),
        Divider(color: ColorConstants.greenColor,thickness:2),
      ],
    );
      /*
      Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: CommonConstants.largeText,
          color: ColorConstants.greenColor,
          fontWeight: FontWeight.bold,
          fontFamily: CommonConstants.largeTextFont),
    );

       */

  }
}