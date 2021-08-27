import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:wibu_chat_app/components/login_card.dart';
import 'package:wibu_chat_app/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: BodyWelcomeScreen(),
        ),
      ),
    );
  }
}

class BodyWelcomeScreen extends StatelessWidget {
  const BodyWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: AnimatedTextKit(
              totalRepeatCount: 5,
              pause: const Duration(seconds: 2),
              animatedTexts: [
                TyperAnimatedText(
                  'Welcome \nto our \ncommunity',
                  textStyle: kHeadingText,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Hero(
              tag: 'avatar',
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 6,
                height: 70,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/A-1_Pictures_Logo.svg.png',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Expanded(
                child: Text(
                  'Waifu Connection Chat',
                  style: kMainText,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Hero(
              tag: 'login',
              child: LoginCard(
                label: 'Login',
                bgColor: Color(0xFF20B8FB),
                text: kLoginText,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Hero(
              tag: 'register',
              child: LoginCard(
                label: 'Register',
                bgColor: Color(0xFFFFF0E9),
                text: kRegisterText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
