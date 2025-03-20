import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'HomeScreen.dart';
import 'lawbook.dart';
import 'ProfileScreen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        messages.insert(0, {'text': _controller.text, 'isMe': true});
      });
      String userMessage = _controller.text;
      _controller.clear();

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': userMessage}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          messages.insert(0, {'text': data['response'], 'isMe': false});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF84BDE3),
      body: Stack(
        children: [
          Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/legalbot.png'),
                      radius: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'LegalBot',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Chat Section
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
    child: ClipRRect(
    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    padding: EdgeInsets.only(bottom: 150), // Space for input box
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        messages[index]['text'],
                        messages[index]['isMe'],
                      );
                    },
                  ),
    ),
                ),
              ),
            ],
          ),

          // Chat Input Box (Above Bottom Container)
          Positioned(
            bottom: 70, // Adjusted to sit above bottom container
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.black),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),

          // Bottom Fixed Container
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

          Positioned(left: width * 0.30,bottom: 0,child: Icon(Icons.chat,color: Colors.black,size: 45,)),
          Positioned(left: width * 0.60,bottom: 0,
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LawBook(),
                    ),
                  );
                },
                child: Icon(Icons.menu_book_outlined,color: Colors.black,size: 45,)),),

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
    );
  }
}

// Chat Bubble Widget
class ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  ChatBubble(this.text, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            if (!isMe)
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/legalbot.png'),
                radius: 15,
              ),
            Text(
              text,
              style: TextStyle(color: isMe ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
