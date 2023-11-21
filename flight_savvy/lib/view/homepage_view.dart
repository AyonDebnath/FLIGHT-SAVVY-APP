import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_view.dart';
import 'profile_view.dart';

class HomePage extends StatelessWidget {
  final String username;

  HomePage({required this.username});

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginView()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Welcome to the Home Page, $username!'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0, // current index is set to profile
        onTap: (index) {
          if(index==2){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
          }
          // Handle navigation tap
        },
      ),
    );
  }
}
