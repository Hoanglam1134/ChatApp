import 'package:flutter/material.dart';
import 'package:wibu_chat_app/constants.dart';

class UsernameField extends StatelessWidget {
  UsernameField({
    required this.child,
    Key? key,
  }) : super(key: key);
  TextField child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kPadding),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }
}
