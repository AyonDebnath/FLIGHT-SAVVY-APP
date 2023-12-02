import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import '../controller/user_service.dart';

class editInfo extends StatefulWidget {
  @override
  _editInfoState createState() => _editInfoState();
}

class _editInfoState extends State<editInfo> {
  late String defaultName;
  late String defaultPhone;
  late String defaultAddress;
  late TextEditingController nameController;
  late TextEditingController phoneController ;
  late TextEditingController addressController;
  late CollectionReference users = FirebaseFirestore.instance.collection('users');
  final currentUser = auth.FirebaseAuth.instance.currentUser;
  final UserService userService = UserService();

  Future<void> fetchData() async {
    defaultName = await userService.getName(currentUser!.uid);
    defaultPhone = await userService.getPhone(currentUser!.uid);
    defaultAddress = await userService.getAddress(currentUser!.uid);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Details'),
      ),
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the future to complete
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle error case
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            nameController = TextEditingController(text: defaultName);
            phoneController = TextEditingController(text: defaultPhone);
            addressController = TextEditingController(text: defaultAddress);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name:'),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Phone Number:'),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Address:'),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Enter your address',
                    ),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      // Perform actions with the user details, e.g., save to database
                      print('Name: ${nameController.text}');
                      print('Phone Number: ${phoneController.text}');
                      print('Address: ${addressController.text}');
                      _addDetails();
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _addDetails() async {
    await userService.updateName(currentUser!.uid, nameController.text);
    await userService.updatePhone(currentUser!.uid, phoneController.text);
    await userService.updateAddress(currentUser!.uid, addressController.text);
    Navigator.of(context).pop();
  }
}
