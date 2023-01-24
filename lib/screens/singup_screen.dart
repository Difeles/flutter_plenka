import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:plenka/widgets/simple_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plenka/screens/home_screen.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});
  static String id = 'singup_sceen';

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final _auth = FirebaseAuth.instance;
  String? name;
  String? email;
  String? password;

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
              height: 40.0,
            ),
            Container(
              height: 350.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Регистрация',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Ваше имя', icon: Icon(Icons.person)),
                    onChanged: (value) => name = value,
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
                  SimpleButton(
                    text: "Продолжить",
                    onPressed: () async {
                      if (email != null && password != null) {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email!, password: password!);
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
    ;
  }
}
