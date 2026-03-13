import 'package:flutter/material.dart';
import 'package:habbit_tracker/pages/ui/sign/change_sign.dart';
import 'package:habbit_tracker/pages/ui/sign/input_field_data.dart';
import 'package:habbit_tracker/pages/ui/theme/theme.dart';
import 'package:habbit_tracker/pages/ui/widgets/button_navigator.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backround_sign.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(top: 85),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Create your account',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ButtonNavigator(
              navigateTo: '/app', 
              labelText: 'CONTINUE WITH GOOGLE', 
              labelColor: 0xFF3F414E, 
              buttonColor: 0xFFFFFFFF,
              image: 'google_logo.png',
              replace: true,
              elevation: 0.5)),
              Text(
                'OR LOG IN WITH EMAIL',
              style: theme.textTheme.labelSmall,
              ),
              Padding(
              padding: EdgeInsets.only(top: 14),
              child: InputFieldData(hintText: 'Username'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 14),
              child: InputFieldData(hintText: 'Email address'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 14),
              child: InputFieldData(hintText: 'Password', isPassword: true,),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 22, bottom: 20),
              child: ButtonNavigator(navigateTo: '/app', 
              labelText: 'SIGN UP', 
              labelColor: 0xFFFFFFFF, 
              buttonColor: 0xFF8E97FD,
              replace: true)
              ),
                Expanded(child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: Padding(padding: EdgeInsetsGeometry.only(bottom: 40),
                  child: ChangeSign(
                  preface: 'ALREADY HAVE AN ACCOUNT? ', 
                  buttonText: 'SIGN IN',
                  navigateTo: '/in',),
                  )
                ))
          ],
        ),
        ) 
      ),
    );
  }
}