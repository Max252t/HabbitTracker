import 'package:flutter/material.dart';
import 'package:habbit_tracker/pages/ui/theme/theme.dart';
import 'package:habbit_tracker/pages/ui/widgets/button_navigator.dart';

class StartContent extends StatelessWidget {
  const StartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
            scale: 1.65,
            ),
            Text(
              'Welcome to Main Habits',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.only(top: 9),
              child:  Text(
                'Explore the app, Find some peace of mind to achive good habits.',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
            )
            ),
            Expanded(child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 85),
              child: ButtonNavigator(
                navigateTo: '/in', 
                labelText: 'GET STARTED', 
                labelColor: 0xFF555662, 
                buttonColor: 0xFFEBEAEC)
            ))
            )
          ],
        );
  }
}