import 'package:flutter/material.dart';

class ExpandedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ExpandedButtonWidget(
      {required this.text,
      required this.backgroundColor,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: backgroundColor),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
