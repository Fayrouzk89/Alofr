import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';
import '../../constants/common.dart';


class LableTextInner extends StatelessWidget {
  final String text;
  LableTextInner({
    required this.text
  });
  @override
  Widget build(BuildContext context) {

    return  Align(
        alignment: AlignmentDirectional.topCenter,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: CommonConstants.smallText,
              color: ColorConstants.white,
              fontFamily: CommonConstants.largeTextFont),
        ));
  }
}