import 'package:habbit_tracker/pages/ui/main_screen/home_page.dart';
import 'package:habbit_tracker/pages/ui/sign/sign_in/sign_in.dart';
import 'package:habbit_tracker/pages/ui/sign/sign_up/sign_up.dart';

final routes = {
  '/': (context) => const MyHomePage(),
  '/in' : (context) => const SignIn(),
  '/up' : (context) => const SignUp()
};