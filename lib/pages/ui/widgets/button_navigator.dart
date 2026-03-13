import 'package:flutter/material.dart';

class ButtonNavigator extends StatelessWidget {
  final String navigateTo;
  final String labelText;
  final int labelColor;
  final int buttonColor;
  final String? image;
  final double elevation;
  final bool replace;
  
  const ButtonNavigator({
    super.key, 
    required this.navigateTo, 
    required this.labelText, 
    required this.labelColor, 
    required this.buttonColor,
    this.image,
    this.elevation = 0.0,
    this.replace = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(30.0),
      clipBehavior: Clip.antiAlias, 
      child: SizedBox(
        width: 330,
        height: 52,
        child: TextButton(
          onPressed: () {
            if (replace) {
              Navigator.of(context).pushReplacementNamed(navigateTo);
            } else {
              Navigator.of(context).pushNamed(navigateTo);
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Color(buttonColor)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0), 
              ),
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  labelText,
                  style: TextStyle(
                    color: Color(labelColor),
                    fontSize: 17,
                  ),
                ),
              ),
              if (image != null)
                Positioned(
                  left: 16,
                  top: 52 * 0.2, 
                  bottom: 52 * 0.2, 
                  child: Image.asset(
                    'assets/images/$image',
                    fit: BoxFit.contain,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}