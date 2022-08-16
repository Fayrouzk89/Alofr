import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';
import '../constants/common.dart';

class InputFieldPhone1 extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String placeholder;
  final Color color;
  final double fontSize;
  final bool password;
  final String? Function(String?)? validator;
  final IconData? icon;
  final bool? enabled;
  Widget? suffiex;
  InputFieldPhone1({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.placeholder = '',
    this.color = Colors.white,
    this.fontSize = 18.0,
    this.password = false,
    this.validator,
    this.icon,
    this.enabled,
    this.suffiex
  });
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autofocus: false,

      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ], // Only numbers can be entered
      decoration: InputDecoration(
        hintText: this.placeholder,
        hintStyle: TextStyle(
            fontSize:  CommonConstants.hintSizes,
            color: ColorConstants.hintColor,
            // fontWeight: FontWeight.w200,
            fontFamily: CommonConstants.introTextFont
        ),
        isDense: true,
        enabled: (enabled==null ||enabled==true)?true:false,
        fillColor:   ColorConstants.white,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          this.icon, color:  ColorConstants.hintColor,
        ),
        suffixIcon:(suffiex!=null)?suffiex:null,
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
      // keyboardType: this.keyboardType,
      obscureText: this.password,
      autocorrect: false,
      validator: this.validator,

    );
  }
}