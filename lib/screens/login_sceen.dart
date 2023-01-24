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
import 'package:plenka/widgets/text_field.dart';

class LoginSceen extends StatefulWidget {
  const LoginSceen({super.key});
  static String id = 'login_sceen';

  @override
  State<LoginSceen> createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginSceen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? email;
  String? password;
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Image.asset(
                'images/4776016.jpg',
                height: 320.0,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            SizedBox(
              height: 430.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Вход',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  TextFieldInput(
                    hintText: 'Почта',
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  TextFieldInput(
                    hintText: 'Пароль',
                    textInputType: TextInputType.text,
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  // Text('Забыл пароль?', textAlign: TextAlign.end, style: TextStyle(fontSize: 16.0),), Восстановление аккаунта
                  SimpleButton(
                    text: "Войти",
                    onPressed: () async {
                      if (email != null && password != null) {
                        final navigator = Navigator.pushReplacementNamed(
                            context, HomeScreen.id);
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email!, password: password!);
                          if (!mounted) return;
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.id);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50.0,
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
