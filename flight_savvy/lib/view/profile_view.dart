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
                  'assets/frontDesk.png',
                  // height: 21, // Set the desired height
                  width: 150, // Set the desired width
                ),
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(left: 20.0, right: 20.0, top: 20, bottom: 20),
            // Adjust the left padding as needed
            child: const Text(
              "Book faster and manage your details more easily with an account.",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 20.0, bottom: 20),
            // Adjust the left padding as needed
            child: const Text(
              "Manage your account",
              style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              shrinkWrap: true,
              // Use shrinkWrap to allow the ListView to take only the space it needs
              physics: NeverScrollableScrollPhysics(),
              // Disable scrolling for the GridView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 15, // Spacing between columns
                mainAxisSpacing: 15.0, // Spacing between rows
              ),
              itemBuilder: (context, index) {
                // Your grid item widget
                if (index == 0) {
                  return GestureDetector(
                    onTap: () {
                      // Handle tap on the grid item
                      print('Tapped on item $index');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // Replace with your desired background color
                        borderRadius: BorderRadius.circular(
                            15), // Set the border radius for rounded corners
                      ), // Replace with your desired background color
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/details.png',
                            // height: 21, // Set the desired height
                            width: 100, // Set the desired width
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Details',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (index == 1) {
                  return GestureDetector(
                    onTap: () {
                      // Handle tap on the grid item
                      print('Tapped on item $index');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // Replace with your desired background color
                        borderRadius: BorderRadius.circular(
                            15.0), // Set the border radius for rounded corners
                      ), // Replace with your desired background color
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/trips.png',
                            // height: 21, // Set the desired height
                            width: 90, // Set the desired width
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Your Trips',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (index == 2) {
                  return GestureDetector(
                    onTap: () {
                      // Handle tap on the grid item
                      print('Tapped on item $index');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // Replace with your desired background color
                        borderRadius: BorderRadius.circular(
                            15.0), // Set the border radius for rounded corners
                      ), // Replace with your desired background color
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/settings.png',
                            // height: 21, // Set the desired height
                            width: 70, // Set the desired width
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (index == 3) {
                  return GestureDetector(
                    onTap: () {
                      // Handle tap on the grid item
                      print('Tapped on item $index');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // Replace with your desired background color
                        borderRadius: BorderRadius.circular(
                            15.0), // Set the border radius for rounded corners
                      ), // Replace with your desired background color
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/support.png',
                            // height: 21, // Set the desired height
                            width: 150, // Set the desired width
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Support',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
              itemCount: 4, // Number of items in the grid
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, bottom: 20),
            // Adjust the left padding as needed
            child: const Text(
              "Recommended Reads",
              style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Card(
              color: Colors.white,
              child: ListTile(
                title: const Text(
                  'Why choose us?',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                subtitle: Row(
                  children: [
                    const Text(
                      'Travel that works for you and the planet. \nFind out more.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Image.asset(
                      'assets/traveller.png',
                      // height: 21, // Set the desired height
                      width: 61, // Set the desired width
                    ),
                  ],
                ),
                onTap: () {
                  // Handle "Your details" press
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Card(
              color: Colors.white,
              child: ListTile(
                title: const Text(
                  'Sustainability',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Image.asset(
                      'assets/sustainable.png',
                      // height: 21, // Set the desired height
                      width: 65, // Set the desired width
                    ),
                    SizedBox(width: 11,),
                    const Text(
                      'Read how we\'ll lead the transformation\nto greener travel',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),

                  ],
                ),
                onTap: () {
                  // Handle "Your details" press
                },
              ),
            ),
          ),
          // ... Add more cards for other options
        ],
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
        currentIndex: 2, // current index is set to profile
        onTap: (index) {
          // Handle navigation tap
        },
      ),
    );
  }
}
