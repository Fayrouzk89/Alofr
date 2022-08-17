import 'package:flutter/material.dart';

class RichSuggestion extends StatelessWidget {
  final VoidCallback onTap;
  //final AutoCompleteItem autoCompleteItem;

  RichSuggestion( this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: RichText(text: TextSpan(children: getStyledTexts(context))),
        ),
        onTap: onTap,
      ),
    );
  }

  List<TextSpan> getStyledTexts(BuildContext context) {
    final List<TextSpan> result = [];
    final style = TextStyle(color: Colors.grey, fontSize: 15);

    final startText ="";
    if (startText.isNotEmpty) {
      result.add(TextSpan(text: startText, style: style));
    }

    final boldText =
       "";
    result.add(
     TextSpan(text: boldText),
    );

    final remainingText = "";
    result.add(TextSpan(text: remainingText, style: style));

    return result;
  }
}
