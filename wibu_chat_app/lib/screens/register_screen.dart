import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wibu_chat_app/components/login_card.dart';
import 'package:wibu_chat_app/components/text_field.dart';
import 'package:wibu_chat_app/constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Theme.of(context).primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BodyRegisterScreen(),
        ),
      ),
    );
  }
}

class BodyRegisterScreen extends StatefulWidget {
  @override
  State<BodyRegisterScreen> createState() => _BodyRegisterScreenState();
}

class _BodyRegisterScreenState extends State<BodyRegisterScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;

  late String password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: 'avatar',
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - kPadding,
              height: 170,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/avatar.png',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
          const Text(
            'Connect with your waifu',
            style: kMainText,
          ),
          UsernameField(
            child: TextField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: InputBorder.none,
              ),
            ),
          ),
          UsernameField(
            child: TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: const InputDecoration(
                hintText: 'Password',
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              try {
                final user = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                Navigator.pushNamed(context, '/chat');
              } catch (e) {
                print(e);
              }
            },
            child: const Hero(
              tag: 'register',
              child: LoginCard(
                  label: 'Register',
                  bgColor: Color(0xFFFFF0E9),
                  text: kRegisterText),
            ),
          ),
        ],
      ),
    );
  }
}
