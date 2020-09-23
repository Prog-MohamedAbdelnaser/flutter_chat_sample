import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color backgroundColor;

  const AppButton({@required this.onPressed, this.text, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: MaterialButton(
          height: 48,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
