import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.lightBlue[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: size.height * 0.05), // Top padding

                // 🎨 Logo and Title
                Column(
                  children: [
                    Image.asset(
                      'assets/images/lawlady.png',
                      width: size.width * 0.5,
                      height: size.height * 0.3,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Law Assist AI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.08,
                        fontFamily: 'HappyMonkey',
                        color: Colors.black,
                        shadows: const [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 2.0,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // 🚀 Get Started Button
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.1),
                  child: SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () => _checkLoginStatus(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontFamily: 'HappyMonkey',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
