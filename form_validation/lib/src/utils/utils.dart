import 'package:flutter/material.dart';

bool isNumber(String number) {
  if (number.isEmpty) return false;
  final convertedNumber = num.tryParse(number);
  return convertedNumber == null ? false : true;
}

void showAlert(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Información incorrecta'),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}
