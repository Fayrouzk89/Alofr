import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/common.dart';
class InputPassword extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String placeholder;
  final Color color;
  final double fontSize;
  final bool password;
  final String? Function(String?)? validator;
  final IconData? icon;
  InputPassword({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText = '',
    this.placeholder = '',
    this.color = Colors.white,
    this.fontSize = 22.0,
    this.password = true,
    this.validator,
    this.icon
  });

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        hintText: this.widget.placeholder,
        hintStyle: TextStyle(
            fontSize:  CommonConstants.hintSizes,
            color: ColorConstants.hintColor,
            // fontWeight: FontWeight.w200,
            fontFamily: CommonConstants.introTextFont
        ),
         isDense: true,
        fillColor: Colors.grey.shade100,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
            this.widget.icon,color: ColorConstants.hintColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(

            _obscureText ? Icons.visibility : Icons.visibility_off,
            semanticLabel:
            _obscureText ? 'show password' : 'hide password',
             color:  ColorConstants.hintColor,
          ),
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
            color: this.widget.color,width: 1.0,
          ),
        ),
      ),
      controller: this.widget.controller,
      style: TextStyle(
        color: ColorConstants.textColor,
        fontFamily: CommonConstants.introTextFont,
        fontSize: widget.fontSize,
        fontWeight: FontWeight.normal,
      ),
      keyboardType: this.widget.keyboardType,
      obscureText: _obscureText,
      autocorrect: false,
      validator: this.widget.validator,

    );
  }
}