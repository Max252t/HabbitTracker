import 'package:flutter/material.dart';
import 'package:habbit_tracker/pages/ui/theme/theme.dart';

class InputFieldData extends StatefulWidget {
 final String hintText;
 final bool isPassword;
 const InputFieldData({super.key, 
 required this.hintText,
 this.isPassword = false});

  @override
  State<InputFieldData> createState() => _InputFieldDataState();
}

class _InputFieldDataState extends State<InputFieldData> {
  final circularRadius = 12.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 60,
    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: widget.isPassword,
                enableSuggestions: !widget.isPassword,
                autocorrect: !widget.isPassword,
                style: theme.textTheme.bodyMedium,
               decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: theme.textTheme.labelSmall,
                fillColor: Color(0xFFF2F3F7),
                filled: true,
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF2F3F7)),
                borderRadius: BorderRadius.circular(circularRadius),
    ),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFF2F3F7), width: 2.0),
                borderRadius: BorderRadius.circular(circularRadius),
    ),
               ),
            ),
              ),
    );
  }
}