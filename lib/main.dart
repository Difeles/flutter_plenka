import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plenka/screens/home_screen.dart';
import 'package:plenka/screens/singup_screen.dart';
import 'package:plenka/screens/welcome_screen.dart';
import 'screens/login_sceen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginSceen.id, //LoginSceen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginSceen.id: (context) => LoginSceen(),
        SingupScreen.id: (context) => SingupScreen(),
        HomeScreen.id: (context) => HomeScreen()
      },
    );
  }
}
