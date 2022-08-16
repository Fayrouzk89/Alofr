import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/colors.dart';
import '../../constants/common.dart';


class LableHeader extends StatelessWidget {
  final String text;
  LableHeader({
    required this.text
  });
  @override
  Widget build(BuildContext context) {

    return  Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: CommonConstants.normalText,
              color: ColorConstants.textColor,
              fontWeight: FontWeight.bold,
              fontFamily: CommonConstants.largeTextFont),
        ));
  }
}