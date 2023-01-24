import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plenka/screens/home_screen.dart';
import 'package:plenka/screens/singup_screen.dart';
import 'package:plenka/widgets/simple_button.dart';

class LoginSceen extends StatefulWidget {
  const LoginSceen({super.key});
  static String id = 'login_sceen';

  @override
  State<LoginSceen> createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginSceen> {
  String? email;
  String? password;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Image.asset(
                'images/4776016.jpg',
                height: 350.0,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 350.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Вход',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Почта', icon: Icon(Icons.alternate_email)),
                    onChanged: (value) => email = value,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Пароль', icon: Icon(Icons.lock)),
                    onChanged: (value) => password = value,
                  ),
                  Text(
                    'Забыл пароль?',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SimpleButton(
                    text: "Войти",
                    onPressed: () async {
                      if (email != null && password != null) {
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email!, password: password!);
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.id);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                  TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, SingupScreen.id),
                      child: Text(
                        'Зарегистрироваться',
                        style: TextStyle(fontSize: 16.0),
                      ))
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
