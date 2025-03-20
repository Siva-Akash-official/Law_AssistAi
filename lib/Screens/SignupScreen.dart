import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'LoginScreen.dart';
 // Import the HomeScreen

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _isLoading = false;
  bool _isError = false; // Flag to indicate if there is an error

  Future<void> _signUp() async {
    // Check if any fields are empty
    bool _isValidEmail(String email) {
      // Regular Expression for validating email
      final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      return emailRegex.hasMatch(email);
    }
    if (_NameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _isError = true; // Set error flag to true
      });
      return; // Exit the function if fields are empty
    }
    if (!_isValidEmail(_emailController.text)) {
      _showMessage("Invalid email format!", Colors.red);
      return;
    }

    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage("Passwords do not match!", Colors.red);
      return;
    }

    setState(() {
      _isLoading = true;
      _isError = false; // Reset error flag
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/signup'), // Use this for the Android emulator
        headers: {
          'Content-Type': 'application/json', // Set the content type
        },
        body: jsonEncode({
          'name': _NameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) { // Check for 201 status code
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          _showMessage("Sign Up Successful!", Colors.green);
          // Navigate to HomeScreen on successful signup
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          _showMessage(data['message'], Colors.red);
        }
      } else {
        _showMessage("Server Error! Try again later.", Colors.red);
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Stop loading
      });
      _showMessage("Network Error: ${e.toString()}", Colors.red);
    }
  }
  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 874,
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
                    left: 113,
                    top: 364,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontFamily: 'Happy Monkey',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 117,
                    top: 424,
                    child: Container(
                      width: 184,
                      height: 5,
                      decoration: const BoxDecoration(color: Color(0xFF84BDE3)),
                    ),
                  ),
                  Positioned(
                    left: 42,
                    top: 465,
                    child: Container(
                      width: 324,
                      height: 359,
                      decoration: ShapeDecoration(
                        color: const Color(0x3F84BDE3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 75,
                    top: 500,
                    child: _buildTextField(_NameController, "Full Name"),
                  ),
                  Positioned(
                    left: 75,
                    top: 560,
                    child: _buildTextField(_emailController, "Email",),

                  ),
                  Positioned(
                    left: 75,
                    top: 620,
                    child: _buildTextField(_passwordController, "Password",
                        isPassword: true),
                  ),
                  Positioned(
                    left: 75,
                    top: 680,
                    child: _buildTextField(
                        _confirmPasswordController, "Confirm Password",
                        isPassword: true),
                  ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Positioned(
                      left: 97,
                      top: 737,
                      child: GestureDetector(
                        onTap: _signUp,
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
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFFFFFCFC),
                              fontSize: 30,
                              fontFamily: 'Happy Monkey',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const Positioned(
                    left: 80,
                    top: 787,
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Happy Monkey',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 260,
                    top: 787,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                        // Navigate to Login Screen
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF84BDE3),
                          fontSize: 15,
                          fontFamily: 'Happy Monkey',
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
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

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false}) {
    return Container(
      width: 258,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: _isError && controller.text.isEmpty ? Colors.red : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200]
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,

        ),
      ),
    );
  }
}