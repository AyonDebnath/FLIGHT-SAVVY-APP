import 'package:firebase_auth/firebase_auth.dart';
import 'package:flight_savvy/view/signup_view.dart';
import 'package:flutter/material.dart';

import 'editDetails_view.dart';
import 'login_view.dart';
import 'user_info.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final isGuest = _auth.currentUser?.isAnonymous ?? true;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your details', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isGuest ? _buildGuestContent(context) : CardList(),
    );
  }

  Widget _buildGuestContent(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/welcome_guest.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              SizedBox(height: 30),
              Text(
                'Welcome, Guest!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Log in or sign up to view your account details and manage your bookings.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 30),
              _buildButton(context, () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView())), 'Login', Colors.teal, Colors.white),
              SizedBox(height: 10),
              _buildButton(context, () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupView())), 'Sign Up', Colors.orange, Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, VoidCallback onPressed, String label, Color backgroundColor, Color textColor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class CardList extends StatelessWidget {
  void _signOut(BuildContext context) {
    try {
      FirebaseAuth.instance.signOut();
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
    return Column(
      children: <Widget>[
        _buildClickableCard(
          title: 'User info',
          subtitle: '',
          color: Colors.white,
          index: 0,
          context: context,
        ),
        _buildClickableCard(
          title: 'Edit info',
          subtitle: '',
          color: Colors.white,
          index: 1,
          context: context,
        ),
        SizedBox(height: 10),
        ButtonTheme(
          minWidth: 100.0, // Set the desired width
          child: ElevatedButton(
            onPressed: () async {
              _signOut(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              // Set the background color of the button
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Set rounded corners
              ),
              elevation: 4.0, // Set the elevation of the button
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Text(
                'Log out',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color
                ),
              ),
            ),
          ),
        ),
        // Add more cards as needed
      ],
    );
  }

  Widget _buildClickableCard(
      {required String title,
      required String subtitle,
      required Color color,
      required int index,
      required context}) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => userInfo()),
          );
        }
        if (index == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => editDetails()),
          );
        }
        print("index:$index pressed");
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            // subtitle: Text(
            //   subtitle,
            //   style: TextStyle(
            //     color: Colors.black,
            //   ),
            // ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
