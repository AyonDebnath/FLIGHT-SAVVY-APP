import 'package:firebase_auth/firebase_auth.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ), // Set the preferred size of the underline
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.of(context).pop();
          },
        ),
      ),
      body: CardList(),
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
