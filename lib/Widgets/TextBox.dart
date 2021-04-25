import 'package:flutter/material.dart';

import '../constant.dart';

class TextBox extends StatelessWidget {
  TextBox(this.title, this.lines, this.control);
  final String title;
  final int lines;
  final TextEditingController control;
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(height: 1.5, fontSize: 15, color: Colors.indigo[400]),
      cursorWidth: 3.0,
      controller: control,
      maxLines: lines,
      decoration: InputDecoration(
        filled: true,
        hintText: title,
        hintStyle: TextStyle(
            color: colorgrad2, fontSize: 20, fontWeight: FontWeight.bold),
        fillColor: Colors.white,
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
