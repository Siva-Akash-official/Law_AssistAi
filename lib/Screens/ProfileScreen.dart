import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String email = "";
  bool isEditing = false;
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  Future<void> _fetchProfile() async {
    setState(() => isLoading = true);
    int? userId = await getUserId();

    if (userId != null) {
      final response =
      await http.get(Uri.parse('http://10.0.2.2:5000/profile/$userId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          name = data['user']['name'] ?? "";
          email = data['user']['email'] ?? "";

          nameController.text = name;
          emailController.text = email;
        });
      } else {
        _showError("Failed to load profile. Try again later.");
      }
    } else {
      _showError("User ID not found.");
    }
    setState(() => isLoading = false);
  }

  Future<void> _updateProfile() async {
    setState(() => isLoading = true);
    int? userId = await getUserId();

    if (userId != null) {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:5000/profile/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': nameController.text,
          'email': emailController.text,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          name = nameController.text;
          email = emailController.text;
          isEditing = false;
        });
        _showSuccess("Profile updated successfully!");
      } else {
        _showError("Failed to update profile.");
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF84BDE3),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  AssetImage('assets/images/profile.png'),
                ),
                const SizedBox(height: 20),
                _buildTextField('Name', nameController, isEditing),
                const SizedBox(height: 20),
                _buildTextField('Email', emailController, isEditing),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF84BDE3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                      ),
                      onPressed: () {
                        if (isEditing) {
                          _updateProfile();
                        } else {
                          setState(() => isEditing = true);
                        }
                      },
                      child: Text(
                        isEditing ? 'Save Profile' : 'Edit Profile',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 24),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      onPressed: _logout,
                      child: const Text(
                        'Logout',
                        style:
                        TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      bool enabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        enabled
            ? TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)),
            filled: true,
            fillColor: Colors.white,
          ),
        )
            : Text(
          controller.text,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
