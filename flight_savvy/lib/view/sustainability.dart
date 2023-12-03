import 'package:flutter/material.dart';

class sustainability extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sustaibability'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color: Colors.black,
              height: 1.0,
            ), // Set the preferred size of the underline
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
              'Our Steps Toward Sustainability.\n\nHelping every traveler explore our world effortlessly, for generations to come.\n\nWe are committed to helping shape a more responsible future for travel in collaboration with our partners.',
              style: TextStyle(fontSize: 18)),
        ));
  }
}
