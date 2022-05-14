import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Authenticate/LoginScreen.dart';
import 'package:flutter_application_1/Screen/HomeScreen.dart';

class Authenticate extends StatelessWidget {
  Authenticate({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
