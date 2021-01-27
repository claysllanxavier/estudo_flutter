import 'package:flutter/material.dart';

class TransictionDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransictionDialog({@required this.onConfirm});

  @override
  _TransictionDialogState createState() => _TransictionDialogState();
}

class _TransictionDialogState extends State<TransictionDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        controller: _passwordController,
        maxLength: 4,
        obscureText: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          fontSize: 64.0,
          letterSpacing: 16,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
          child: Text('Confirm'),
        )
      ],
    );
  }
}
