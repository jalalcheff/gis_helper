import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gis_helper/presentation/screen/core_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CoreScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            Center(child: Lottie.asset("images/lottie.json")),
            AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText("GIS خرائط المحولات", textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 32), duration: Duration(seconds: 3)),
                ],
    )
          ],
        )
    );
  }
}
