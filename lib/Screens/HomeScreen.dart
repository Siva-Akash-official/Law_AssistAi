import 'package:flutter/material.dart';
import 'lawbook.dart';
import 'ChatScreen.dart';
import 'ProfileScreen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: screenWidth,
            height: screenHeight,
            color: const Color(0xFF84BDE3),
          ),

          // Bottom White Container
          Positioned(
            top: screenHeight * 0.32,
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.68,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          // Navigation Bar (Bottom)
          Positioned(
            bottom: 0,
            child: Container(
              width: screenWidth,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFCFC),

              ),
            ),
          ),

          // Law Book Icon
          Positioned(
            left: screenWidth * 0.6,
            top: screenHeight * 0.39,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LawBook(),
                  ),
                );
              },
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image.asset("assets/images/book.png"),
                ),

                const SizedBox(height: 10),
                const Text(
                  'Law Book',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Happy Monkey',
                  ),
                ),
              ],
            ),
          ),
          ),
          // LegalBot Icon
          Positioned(
            left: screenWidth * 0.1,
            top: screenHeight * 0.39,
            child: GestureDetector( onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                ),
              );
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/images/legalbot.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 10),
                const Text(
                  'LegalBot',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Happy Monkey',
                  ),
                ),
              ],
            ),
            ),
          ),

          // Title Text
          Positioned(
            left: screenWidth * 0.15,
            top: screenHeight * 0.65,
            child: const Text(
              'Your Legal\nCompanion at\nYour Fingertips',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontFamily: 'Happy Monkey',
              ),
            ),
          ),

          // Law Lady Image
          Positioned(
            top: 40,
            left: (screenWidth - 120) / 2,
            child: Image.asset(
              "assets/images/lawlady.png",
              width: 120,
              height: 120,
            ),
          ),

          Positioned(left: screenWidth * 0.02,bottom: 0,child: Icon(Icons.home,color: Colors.black,size: 45,)),
          Positioned(left: screenWidth * 0.60,bottom: 0,
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
          Positioned(left: screenWidth * 0.30,bottom: 0,
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
          Positioned(right: screenWidth * 0.02,bottom: 0,
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
