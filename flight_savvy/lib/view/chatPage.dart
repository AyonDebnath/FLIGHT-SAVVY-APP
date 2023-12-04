import 'dart:ui';
import 'package:flight_savvy/view/chatwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class chatPage extends StatefulWidget {
  final String username;

  chatPage(this.username);

  @override
  State<chatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<chatPage> {
  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.height / 838.4;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade200,
                Colors.white,
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0 * scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20 * scale),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 200 * scale,
                ),
              ),
              Gap(20 * scale),
              Text(
                'Hi, ${widget.username}!',
                style: TextStyle(
                  fontSize: 36 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gap(10 * scale),
              Center(
                child: Text(
                  'Welcome to FlySavvy',
                  style: TextStyle(
                    fontSize: 24 * scale,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey[800],
                  ),
                ),
              ),
              Gap(20 * scale),
              Expanded(
                child: Center(
                  child: Container(
                    width: 340 * scale,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: chatWidget(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
