import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle todoTitle() {
    return TextStyle(
        color: Colors.grey[700], fontSize: 16.0, fontWeight: FontWeight.normal);
  }

  static TextStyle mediumTitle() {
    return TextStyle(
        color: Colors.grey[700], fontSize: 16.0, fontWeight: FontWeight.bold);
  }

  static TextStyle dueDate() {
    return TextStyle(
        color: Colors.grey[300], fontSize: 13.0, fontWeight: FontWeight.normal);
  }
}
