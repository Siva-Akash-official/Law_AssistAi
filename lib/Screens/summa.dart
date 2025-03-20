/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'LoginScreen.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreen createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? sentOTP; // Store the generated OTP

  void _sendOTP() async {
    String email = _emailController.text.trim();
    if (email.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/forgot_password'),
        // Use this for the Android emulator
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP sent to $email')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an email!')),
      );
    }
  }

  void _verifyOTP() async {
    String enteredOTP = _otpController.text.trim();
    String email = _emailController.text.trim();
    if (enteredOTP.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/verify_otp'),
        // Use this for the Android emulator
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email':email,'otp': enteredOTP}),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP Verified Successfully!')),
        );
        // Navigate to HomeScreen on successful verification
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP! Please try again.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 402,
              height: 874,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: -217.72,
                    top: -290,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(0.78),
                      child: Container(
                        width: 596.01,
                        height: 289.24,
                        decoration:
                        const BoxDecoration(color: Color(0xFF84BDE3)),
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
                  const Positioned(
                    left: 23,
                    top: 369,
                    child: SizedBox(
                      width: 363,
                      height: 61,
                      child: Text(
                        'Forget Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: 'Happy Monkey',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 23,
                    top: 415,
                    child: Container(
                      width: 340,
                      height: 5,
                      decoration: const BoxDecoration(color: Color(
                          0xFF84BDE3)),
                    ),
                  ),
                  Positioned(
                    left: 39,
                    top: 469,
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
                    left: 77,
                    top: 540,
                    child: SizedBox(
                      width: 255,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 94,
                    top: 610,
                    child: GestureDetector(
                      onTap: _sendOTP,
                      child: Container(
                        width: 214,
                        height: 47,
                        decoration: BoxDecoration(
                          color: const Color(0xFF84BDE3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Happy Monkey',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 77,
                    top: 670,
                    child: SizedBox(
                      width: 255,
                      child: TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter OTP",
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 94,
                    top: 740,
                    child: GestureDetector(
                      onTap: _verifyOTP,
                      child: Container(
                        width: 214,
                        height: 47,
                        decoration: BoxDecoration(
                          color: const Color(0xFF84BDE3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Verify OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
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
          ],
        ),
      ),
    );
  }

}*/