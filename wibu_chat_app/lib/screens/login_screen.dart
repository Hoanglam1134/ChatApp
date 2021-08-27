import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wibu_chat_app/components/login_card.dart';
import 'package:wibu_chat_app/components/text_field.dart';
import 'package:wibu_chat_app/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
          body: BodyLoginScreen(),
        ),
      ),
    );
  }
}

class BodyLoginScreen extends StatefulWidget {
  BodyLoginScreen({Key? key}) : super(key: key);

  @override
  State<BodyLoginScreen> createState() => _BodyLoginScreenState();
}

class _BodyLoginScreenState extends State<BodyLoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

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
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              try {
                print(email);
                print(password);
                final user = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                if (user.user != null) {
                  Navigator.pushNamed(context, '/chat');
                }
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      'Wrong email or password!',
                      //style: kMainText,
                    ),
                  ),
                );
                print(e);
              }
            },
            child: const Hero(
              tag: 'login',
              child: LoginCard(
                  label: 'Login', bgColor: Color(0xFF20B8FB), text: kLoginText),
            ),
          ),
        ],
      ),
    );
  }
}
