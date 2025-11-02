import 'package:almasah_dates/features/auth/data/services/password_service.dart';
import 'package:flutter/material.dart';

Future<bool> showPasswordDialog(BuildContext context) async {
  final _controller = TextEditingController();
  bool isValid = false;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Enter Password'),
      content: TextField(
        controller: _controller,
        obscureText: true,
        decoration: const InputDecoration(labelText: 'Password'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (PasswordService.checkPassword(_controller.text)) {
              isValid = true;
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Incorrect password')),
              );
            }
          },
          child: const Text('Submit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    ),
  );

  return isValid;
}
