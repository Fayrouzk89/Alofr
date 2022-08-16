import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';
import '../constants/common.dart';

class InputFieldMulti extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String placeholder;
  final Color color;
  final double fontSize;
  final bool password;
  final String? Function(String?)? validator;
  final IconData? icon;
  InputFieldMulti({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.placeholder = '',
    this.color = Colors.white,
    this.fontSize = 15.0,
    this.password = false,
    this.validator,
    this.icon
  });
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autofocus: false,
      keyboardType: TextInputType.multiline,
      minLines: 4,//Normal textInputField will be displayed
      maxLines: 8,// when user presses enter it will adapt to it
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(5000),
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
      obscureText: this.password,
      autocorrect: false,
      validator: this.validator,

    );
  }
}