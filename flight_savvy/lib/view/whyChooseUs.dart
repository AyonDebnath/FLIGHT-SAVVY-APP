import 'package:flutter/material.dart';

class whyChooseUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Why choose us'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.black,
            height: 1.0,
          ), // Set the preferred size of the underline
        ),
      ),
      body: Container(
        color: Colors.white12,
        child: SingleChildScrollView( child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
                children: [
                  Image.asset('assets/airplane.png'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('We want to bring the world to you. From choosing a destination to finding the best price, we want you to have all the options at your fingertips.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'That\'s why we\'re focused on making travel better for everyone.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'To make sure you get the most for your money and from your trip.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'And to make our industry more transparent and deserving of your trust.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'This spirit shines through everything we do.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'We\'ve always got your back and we\'re proud to be the most trusted travel search site in the world.',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
        ),
        ),
      ),
    );
  }
}
