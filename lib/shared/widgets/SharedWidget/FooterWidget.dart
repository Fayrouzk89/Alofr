import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/common.dart';

class FooterWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0,top: 10),
        child: Text(
          CommonConstants.bottomFooter,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: CommonConstants.smallText,
            color: ColorConstants.tipColor,
          ),
        ),
      ),
    );
  }
}
