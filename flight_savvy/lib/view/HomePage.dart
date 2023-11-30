import 'package:flight_savvy/main.dart';
import 'package:flight_savvy/view/chatPage.dart';
import 'package:flight_savvy/view/profile_view.dart';
import 'package:flutter/material.dart';
import '../controller/controller.dart';
import 'SearchPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  final String username;

  HomePage({required this.username});

  @override
  State<HomePage> createState() => HomeState(username: this.username);
}

class HomeState extends State<HomePage> {
  int currIndex = 0;
  var cont = controller();

  final String username;
  HomeState({required this.username});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<String>>>(
        future: cont.getAirports(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: Text('fetching')),
            );
          }

          Map<String, List<String>>? data = snapshot.data;
          List<Widget> pages = [
            chatPage(username),
            SearchPage(data),
            ProfilePage(
              username: username,
            )
          ];

          return Scaffold(
            body: pages[currIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
              backgroundColor: Colors.white70,
              child: Icon(
                MyApp.themeNotifier.value == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.lightBlueAccent,
              animationDuration: const Duration(milliseconds: 350),
              items: const <Widget>[
                Icon(Icons.home, size: 30),
                Icon(Icons.search, size: 30),
                Icon(Icons.person, size: 30),
              ],
              onTap: (index) {
                setState(() {
                  currIndex = index;
                });
                ;
              },
            ),
          );
        });
  }
}
