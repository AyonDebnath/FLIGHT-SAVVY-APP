import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flight_savvy/main.dart';
import 'package:flutter/material.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
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
          color: Colors.black,
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

class CardList extends StatefulWidget {
  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool isSwitched = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // List of items for the dropdown
  List<String> currencies = ['USD', 'CAD'];
  //
  // // Selected item
  // String selectedCurrency = 'CAD';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Theme Toggle Switch:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 10),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                    isSwitched = value;
                  });
                  // Perform actions based on the switch state
                  print('Switch is $isSwitched');
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Selected Currency:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButton<String>(
                  value: MyApp.selectedCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      MyApp.selectedCurrency = newValue!;
                    });
                  },
                  items:
                      currencies.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  underline: Container(),
                  // Remove the default underline
                  icon: Icon(Icons.arrow_drop_down),
                  // Add an arrow icon
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText1?.color ??
                        Colors.black,
                  ),
                  isExpanded:
                      false, // This property allows the dropdown to take the minimum space needed
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
