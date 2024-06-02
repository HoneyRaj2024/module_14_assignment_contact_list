import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:module_14_assignment_contact_list/ui_screen/main_screen.dart'; // Import the main App screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _animation = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(_controller);

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => AppScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.purple],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _controller,
                    child: Image.asset(
                      'assets/man.png',
                      width: 250,
                      height: 250,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('Contact List'),
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
