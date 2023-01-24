import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plenka/screens/home_screen.dart';
import 'package:plenka/screens/singup_screen.dart';
import 'package:plenka/screens/welcome_screen.dart';
import 'screens/login_sceen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyARrxQYnzOBJgKsVcyD-nRRCIrfUNk_K80",
            appId: "1:769952124061:web:497ff25fc3f40a9e4e1874",
            messagingSenderId: "G-ST6KS157V4",
            projectId: "kitten-87b87",
            storageBucket: "kitten-87b87.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginSceen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginSceen.id: (context) => LoginSceen(),
        SingupScreen.id: (context) => SingupScreen(),
        HomeScreen.id: (context) => HomeScreen()
      },
    );
  }
}
