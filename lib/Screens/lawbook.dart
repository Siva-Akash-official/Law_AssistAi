import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'HomeScreen.dart';
import 'ChatScreen.dart';
import 'ProfileScreen.dart';

class LawBook extends StatefulWidget {
  @override
  _LawBookState createState() => _LawBookState();
}

class _LawBookState extends State<LawBook> {
  final TextEditingController _articleController = TextEditingController();
  String _title = "";
  String _description = "";
  String _message = "";

  Future<void> fetchArticle() async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:5000/get_article"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"article": _articleController.text}),
    );
    final data = jsonDecode(response.body);

    setState(() {
      if (response.statusCode == 200) {
        _title = data['title'] ?? "";
        _description = data['description'] ?? "";
        _message = "";
      } else {
        _title = "";
        _description = "";
        _message = data['message'] ?? "Error fetching article";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(color: Color(0xFF84BDE3)),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: height * 0.32,
                    child: Container(
                      width: width,
                      height: height * 0.75,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),

                  /// **Search Bar**
                  Positioned(
                    left: width * 0.08,
                    top: height * 0.22,
                    child: Container(
                      width: width * 0.85,
                      height: height * 0.08,
                      child: TextField(
                        controller: _articleController,
                        decoration: InputDecoration(
                          hintText: 'Enter Article Number',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// **Search Button**
                  Positioned(
                    left: width * 0.75,
                    top: height * 0.225,
                    child: ElevatedButton(
                      onPressed: fetchArticle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF84BDE3),
                        padding: EdgeInsets.all(12),
                      ),
                      child: Icon(Icons.search, color: Colors.white),
                    ),
                  ),

                  /// **Back Button**


                  /// **Law Lady Image**
                  Positioned(
                    left: width * 0.35,
                    top: height * 0.06,
                    child: Image.asset(
                      "assets/images/lawlady.png",
                      width: width * 0.3,
                    ),
                  ),

                  /// **Scrollable Article Details**
                  Positioned(
                    top: height * 0.35,
                    left: width * 0.08,
                    right: width * 0.08,
                    bottom: height * 0.1, // Ensure space for the bottom bar
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_message.isNotEmpty)
                            Text(
                              _message,
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            )
                          else ...[
                            Text(
                              "Title: $_title",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Description: $_description",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  /// **Bottom Bar**
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFCFC),

                      ),
                    ),
                  ),
                  Positioned(left: width * 0.02,bottom: 0,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homescreen(),
                            ),
                          );
                        },
                      child: Icon(Icons.home,color: Colors.black,size: 45,)),),
                  Positioned(left: width * 0.60,bottom: 0,child: Icon(Icons.menu_book,color: Colors.black,size: 45,)),
                  Positioned(left: width * 0.30,bottom: 0,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(),
                            ),
                          );
                        },
                        child: Icon(Icons.chat,color: Colors.black,size: 45,)),),
                  Positioned(right: width * 0.02,bottom: 0,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ),
                          );
                        },
                        child: Icon(Icons.person,color: Colors.black,size: 45,)),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
