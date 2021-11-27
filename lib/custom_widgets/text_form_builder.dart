import 'package:flutter/material.dart';

class TextFormBuilder extends StatelessWidget {
  String hintText;
  TextEditingController textEditingController;
  TextInputType textInputType;
  TextFormBuilder({Key? key, required this.hintText, required this.textEditingController, required this.textInputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return TextFormField(
      controller: textEditingController,
      keyboardType: textInputType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: size.width*.02, vertical: size.width*.02)
      ),
      textAlign: TextAlign.justify,
    );
  }
}
