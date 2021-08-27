import 'package:flutter/material.dart';
import 'package:wibu_chat_app/constants.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    Key? key,
    required this.label,
    required this.bgColor,
    required this.text,
  }) : super(key: key);
  final String label;
  final Color bgColor;
  final TextStyle text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      width: MediaQuery.of(context).size.width - kPadding * 2,
      alignment: Alignment.center,
      child: Text(
        label,
        style: text,
      ),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(2, 2),
              blurRadius: 4,
              spreadRadius: 0.5,
            ),
          ]),
    );
  }
}
