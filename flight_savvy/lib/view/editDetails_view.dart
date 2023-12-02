import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../controller/user_service.dart';

class editDetails extends StatefulWidget {
  @override
  _editDetailsState createState() => _editDetailsState();
}

class _editDetailsState extends State<editDetails> {
  late String defaultName;
  late String defaultPhone;
  late String defaultAddress;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  late TextEditingController addressController;
  late CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final currentUser = auth.FirebaseAuth.instance.currentUser;
  final UserService userService = UserService();
  final ImagePicker _picker = ImagePicker();
  String? imageURL;
  XFile? _image;

  Future<void> fetchData() async {
    defaultName = await userService.getName(currentUser!.uid);
    defaultPhone = await userService.getPhone(currentUser!.uid);
    defaultAddress = await userService.getAddress(currentUser!.uid);
    imageURL = await userService.getImageUrl(currentUser!.uid);
    return;
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (_image == null) {
        _image = image;
        _uploadImageToFirestorage();
      }
    });
  }

  Future<dynamic> _uploadImageToFirestorage() async {
    if (_image == null) return;
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('images/${currentUser.uid}/${_image!.name}');
    try {
      final uploadTask = await firebaseStorageRef.putFile(File(_image!.path));
      if (uploadTask.state == TaskState.success) {
        final downloadURL = await firebaseStorageRef.getDownloadURL();
        // print(imageURLs);
        print("Uploaded to: $downloadURL");
        imageURL = downloadURL;
        print(imageURL);
        // imageURLs.add(downloadURL);
        // print(imageURLs);
      }
    } catch (e) {
      print("Failed to upload image: $e");
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      _uploadImageToFirestorage();
    });
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
                  const SizedBox(height: 20),
                  Row(children: [
                    Text(
                      "Pick Profile Picture from Gallery: ",
                    ),
                    IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: _pickImageFromGallery,
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Row(children: [
                    Text(
                      "Capture Profile Picture from Camera: ",
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: _pickImageFromCamera,
                    ),
                  ]),
                  SizedBox(height: 20.0),
                  Visibility(
                      visible: _image!=null || imageURL!=null && imageURL != '', // your boolean condition here,
                      child: Column(
                        children: [
                          if(_image!=null)
                            Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                              width: 100.0,
                              height: 100.0,
                            ),
                          if(_image==null && imageURL!=null && imageURL != '')
                            Image.network(
                              imageURL!,
                              width: 100.0, // Set the width of the image
                              height: 100.0, // Set the height of the image
                              fit: BoxFit.cover, // Set the BoxFit property as needed
                            ),
                        ],
                      ),// your widget here,
                  ),
                  SizedBox(height: 20, ),
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
    if(imageURL!=null && imageURL!='') {
      await userService.updateImageUrl(currentUser!.uid, imageURL);
    }
    Navigator.of(context).pop();
  }
}
