import 'package:flutter/material.dart';
import 'package:flight_savvy/main.dart';
import 'user_info.dart';
import 'editInfo_view.dart';

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
        title: Text('Settings'),
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


class CardList extends StatefulWidget {
  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  bool isSwitched = false;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Toggle Switch',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(width: 20),
          Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light
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
    );
  }
}
