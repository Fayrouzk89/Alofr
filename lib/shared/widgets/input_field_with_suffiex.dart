import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';
import '../constants/common.dart';

class InputFieldWithSuffiex extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String placeholder;
  final Color color;
  final double fontSize;
  final bool password;
  final String? Function(String?)? validator;
  final IconData? icon;
  final Text? suffiex ;
  InputFieldWithSuffiex({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.placeholder = '',
    this.color = Colors.white,
    this.fontSize = 18.0,
    this.password = false,
    this.validator,
    this.icon,
    this.suffiex
  });
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      //autofocus: false,

      keyboardType: TextInputType.numberWithOptions(signed: false,decimal: true),
      /*
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ]
      , // Only numbers can be entered
       */
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: InputDecoration(
        hintText: this.placeholder,
        hintStyle: TextStyle(
            fontSize:  CommonConstants.hintSizes,
            color: ColorConstants.hintColor,
            // fontWeight: FontWeight.w200,
            fontFamily: CommonConstants.introTextFont
        ),
        isDense: true,
        fillColor:   ColorConstants.white,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          this.icon, color:  ColorConstants.hintColor,
        ),
        suffix: this.suffiex,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(color: Colors.white, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: const BorderSide(color: Colors.white, width: 1.0)),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(
            color: this.color,width: 1.0,
          ),
        ),
      ),
      controller: this.controller,
      style: TextStyle(
        color: ColorConstants.textColor,
        fontFamily: CommonConstants.introTextFont,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      ),
      autocorrect: false,
      validator: this.validator,

    );
  }
}