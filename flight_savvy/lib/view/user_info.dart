import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import '../controller/user_service.dart';
import '../model/user.dart';

class userInfo extends StatefulWidget {
  const userInfo({super.key});

  @override
  State<userInfo> createState() => _userInfoState();
}

class _userInfoState extends State<userInfo> {
  final UserService userService = UserService();
  final currentUser = auth.FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
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
      body: StreamBuilder<List<User>>(
        stream: userService.getUsers(),
        builder: (context, snapshot) {
          // Show a loading indicator until data is fetched from Firestore.
          if (!snapshot.hasData)
            return const Center(
              child: Text('No entries found'),
            );
          final users = snapshot.data!;
          for (int i = 0; i < users.length; i++) {
            if (users[i].id == currentUser!.uid) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible:
                          users[i].imageUrl != null && users[i].imageUrl != '',
                      child: Center(
                        child: CircleAvatar(
                          radius: 60,
                          // Set the radius of the circle
                          backgroundColor: Colors.grey[300],
                          // Set the background color
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(users[i].imageUrl!),
                          ),
                        ),
                      ), // your widget here,
                    ),
                    Visibility(
                      visible:
                      users[i].imageUrl == null || users[i].imageUrl == '',
                      child: Center(
                        child: CircleAvatar(
                          radius: 60,
                          // Set the radius of the circle
                          backgroundColor: Colors.grey[300],
                          // Set the background color
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/fly-savvy.appspot.com/o/images%2Fwhite-color-solid-background-1920x1080.png?alt=media&token=31ff20ed-a117-4942-ab87-0adfacef071e'),
                          ),
                        ),
                      ), // your widget here,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Username:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          users[i].username,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: users[i].Name != null && users[i].Name != '',
                      child: Row(
                        children: [
                          Text(
                            'Name:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            users[i].Name!,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: users[i].Phone != null && users[i].Phone != '',
                      child: Row(
                        children: [
                          Text(
                            'Phone:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            users[i].Phone!,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          users[i].Address != null && users[i].Address != '',
                      child: Row(
                        children: [
                          Text(
                            'Address:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            users[i].Address!,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return Text('');
        },
      ),
    );
  }
}
