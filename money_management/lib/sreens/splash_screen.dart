import 'package:flutter/material.dart';
import 'package:money_management/main.dart';
import 'package:money_management/sreens/sreen_home.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
   gotoScreenHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              'C:/Users/pro/Desktop/New folder/money_management/assets/1715927131801-removebg-preview.png'),
          const Text(
            'MONEY MANAGE',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> gotoScreenHome() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return const ScreenHome();
    }));
  }
}
