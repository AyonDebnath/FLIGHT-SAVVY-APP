import 'package:flutter/material.dart';
import '../model/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.user});

  final User user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("User Profile"),
      ),
      body: Center(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(widget.user.profileImage),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.user.name,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.user.email,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Add your log-out logic here
                print('Log Out Pressed');
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
