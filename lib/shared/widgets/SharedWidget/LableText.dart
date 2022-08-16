import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';
import '../../constants/common.dart';


class LableText extends StatelessWidget {
  final String text;
  LableText({
    required this.text
  });
  @override
  Widget build(BuildContext context) {

    return  Align(
        alignment: AlignmentDirectional.center,
        child: Text(
             text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: CommonConstants.normalText,
              color: ColorConstants.textColor,
              fontFamily: CommonConstants.largeTextFont),
        ));
  }
}