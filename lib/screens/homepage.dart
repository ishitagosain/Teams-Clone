import 'package:flutter/material.dart';
import 'package:twoconnect/screens/profilescreen.dart';
import 'package:twoconnect/screens/videoconferencescreen.dart';
import 'package:twoconnect/variables.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageoptions = [
    VideoConferenceScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange[700],
        selectedLabelStyle: mystyle(17, Colors.orange[700]),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: mystyle(17, Colors.black),
        currentIndex: page,
        onTap: (index){
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Video Call"),
            icon: Icon(Icons.video_call, size: 32),
          ),
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon( Icons.person, size: 32),
          ),
        ],
      ),

      body: pageoptions[page],
    );
  }
}