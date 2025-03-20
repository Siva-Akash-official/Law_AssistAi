/*import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'SignupScreen.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 402,
            height: 874,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: -217.73,
                  top: -290,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..translate(0.0, 0.0)
                      ..rotateZ(0.78),
                    child: Container(
                      width: 596.01,
                      height: 289.24,
                      decoration: const BoxDecoration(color: Color(0xFF84BDE3)),
                    ),
                  ),
                ),
                const Positioned(
                  left: 98,
                  top: 353,
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontFamily: 'Happy Monkey',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 98,
                  top: 418,
                  child: Container(
                    width: 215,
                    height: 5,
                    decoration: const BoxDecoration(color: Color(0xFF84BDE3)),
                  ),
                ),
                Positioned(
                  left: 39,
                  top: 473,
                  child: Container(
                    width: 324,
                    height: 359,
                    decoration: ShapeDecoration(
                      color: const Color(0x7F84BDE3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 98,
                  top: 597,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Container(
                      width: 214,
                      height: 47,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF84BDE3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Happy Monkey',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 94,
                  top: 711,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Container(
                      width: 214,
                      height: 47,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF84BDE3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Happy Monkey',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 99,
            top: 550,
            child: Text(
              'Old User',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5099999904632568),
                fontSize: 25,
                fontFamily: 'Happy Monkey',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 99,
            top: 663,
            child: Text(
              'New User',
              style: TextStyle(
                color: Colors.black.withOpacity(0.44999998807907104),
                fontSize: 25,
                fontFamily: 'Happy Monkey',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 8,
            top: 70,
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/lawlady.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/