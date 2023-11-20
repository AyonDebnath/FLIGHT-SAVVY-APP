import 'package:flutter/material.dart';

import '../model/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.user});

  final User user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //       title: Text("User Profile"),
  //     ),
  //     body: Center(child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           CircleAvatar(
  //             radius: 50.0,
  //             backgroundImage: NetworkImage(widget.user.profileImage),
  //           ),
  //           SizedBox(height: 16.0),
  //           Text(
  //             widget.user.name,
  //             style: TextStyle(
  //               fontSize: 24.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(height: 8.0),
  //           Text(
  //             widget.user.email,
  //             style: TextStyle(
  //               fontSize: 16.0,
  //               color: Colors.grey,
  //             ),
  //           ),
  //           SizedBox(height: 24.0),
  //           ElevatedButton(
  //             onPressed: () {
  //               // Add your log-out logic here
  //               print('Log Out Pressed');
  //             },
  //             child: Text('Log Out'),
  //           ),
  //         ],
  //       ),
  //     ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return ProfilePage();
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          // Add user greeting, login, and signup button
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ButtonTheme(
                    minWidth: 100.0, // Set the desired width
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle login or signup press
                      },
                      child: Text('Log in or sign up'),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                // Add some space between the button and the image
                Image.asset(
                  'assets/flightIcon.png',
                  // height: 21, // Set the desired height
                  width: 150, // Set the desired width
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20, bottom: 20), // Adjust the left padding as needed
            child: const Text(
              "Book faster and manage your details more easily with an account.",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20.0, bottom: 20), // Adjust the left padding as needed
            child: const Text(
              "Manage your account",
              style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
            ),
          ),


          // Add cards for "Your details", "Your trips", etc.
          Card(
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Your details'),
              onTap: () {
                // Handle "Your details" press
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.airplane_ticket),
              title: Text('Your trips'),
              onTap: () {
                // Handle "Your trips" press
              },
            ),
          ),
          // ... Add more cards for other options
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
        currentIndex: 2, // current index is set to profile
        onTap: (index) {
          // Handle navigation tap
        },
      ),
    );
  }
}
