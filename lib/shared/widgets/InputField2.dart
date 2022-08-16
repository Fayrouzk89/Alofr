import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';
import '../constants/common.dart';

class InputField2 extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String placeholder;
  final Color color;
  final double fontSize;
  final bool password;
  final String? Function(String?)? validator;
  final IconData? icon;
  bool? enabled;
  Widget? suffiex;
  FocusNode? myFocusNode;
  InputField2({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.placeholder = '',
    this.color = Colors.white,
    this.fontSize = 15.0,
    this.password = false,
    this.validator,
    this.icon,
    this.enabled,
    this.suffiex,
    this.myFocusNode
  });

  @override
  State<InputField2> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField2> {
  bool isenabled = false;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      focusNode: (widget.myFocusNode!=null)?widget.myFocusNode:null,
      autofocus: false,
      enabled: (widget.enabled==null ||widget.enabled==true)?true:false,
      //enableInteractiveSelection: true,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(100),
        ],
      decoration: InputDecoration(
        hintText: this.widget.placeholder,
        hintStyle: TextStyle(
            fontSize:  CommonConstants.hintSizes,
            color: ColorConstants.hintColor,
            // fontWeight: FontWeight.w200,
            fontFamily: CommonConstants.introTextFont
        ),
        isDense: true,

        fillColor: ColorConstants.whiteBack,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          this.widget.icon, color:  ColorConstants.hintColor,
        ),
        suffixIcon:(widget.suffiex!=null)?widget.suffiex:null,
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
            color: this.widget.color,width: 1.0,
          ),
        ),
      ),
      //  enabled:(widget.enabled==null ||widget.enabled==true)?true:false,

      controller: this.widget.controller,
      style: TextStyle(
        color: ColorConstants.textColor,
        fontFamily: CommonConstants.introTextFont,
        fontSize:  widget.fontSize,
        fontWeight: FontWeight.normal,
      ),
      keyboardType: this.widget.keyboardType,
      obscureText: this.widget.password,
      autocorrect: false,
      validator: this.widget.validator,

    );
  }
}