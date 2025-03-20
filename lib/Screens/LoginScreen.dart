import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'SignupScreen.dart';
import 'ForgetPasswordScreen.dart';
import 'HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', userId);
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    String email = _usernameController.text;
    String password = _passwordController.text;

    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse("http://10.0.2.2:5000/login");
    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      setState(() {
        _isLoading = false;
      });


      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'success') {
          await _saveUserId(jsonResponse['id']);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login Successful!")),
          );
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homescreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(jsonResponse['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User Not Found!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Network error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                        transform: Matrix4.identity()..rotateZ(0.78),
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
                    const Positioned(
                      left: 137,
                      top: 359,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontFamily: 'Happy Monkey',
                        ),
                      ),
                    ),
                    Positioned(
                      left: 64,
                      top: 536,
                      child: SizedBox(
                        width: 275,
                        child: TextFormField(
                          controller: _usernameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            /*final emailRegex = RegExp(
                                r'^[\\w-]+\\.]+@([\\w-]+\\.)+[\\w-]{2,4}\$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Invalid email format';
                            }*/
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
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
                      left: 64,
                      top: 629,
                      child: SizedBox(
                        width: 275,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      Positioned(
                        left: 94,
                        top: 753,
                        child: GestureDetector(
                          onTap: login,
                          child: Container(
                            width: 214,
                            height: 47,
                            decoration: BoxDecoration(
                              color: const Color(0xFF84BDE3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Happy Monkey',
                              ),
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      left: 64,
                      top: 686,
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Color(0xFF84BDE3),
                            fontSize: 15,
                            fontFamily: 'Happy Monkey',
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 65,
                      top: 710,
                      child: Text(
                        'Don’t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Happy Monkey',
                        ),
                      ),
                    ),
                    Positioned(
                      left: 230,
                      top: 710,
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign up',
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
      ),
    );
  }
}