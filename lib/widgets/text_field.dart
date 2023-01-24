import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput(
      {super.key,
      required this.hintText,
      this.isPassword = false,
      required this.textInputType,
      required this.controller});
  final String hintText;
  final bool isPassword;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final borders = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide:
            Divider.createBorderSide(context, color: Colors.black12, width: 0));
    return TextField(
      keyboardType: textInputType,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          // icon: Icon(Icons.alternate_email), возможность добавить иконку
          filled: true,
          fillColor: Colors.black12,
          border: borders,
          focusedBorder: borders,
          enabledBorder: borders),
      // onChanged: (value) => email = value,
    );
  }
}
