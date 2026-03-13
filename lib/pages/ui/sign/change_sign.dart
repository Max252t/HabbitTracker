import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:habbit_tracker/pages/ui/theme/theme.dart';

class ChangeSign extends StatelessWidget {
  final String preface;
  final String buttonText;
  final String navigateTo;
  const ChangeSign({
  super.key, 
  required this.preface, 
  required this.buttonText,
  required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(
      children: [
        TextSpan(
          text: preface,
          style: theme.textTheme.labelSmall
        ),
        TextSpan(
          text: buttonText,
          style: theme.textTheme.labelSmall?.copyWith(color: Color(0xFF0C8CE9)),
          recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.of(context).pushReplacementNamed(navigateTo)
        )
      ]
    ));
  }
}