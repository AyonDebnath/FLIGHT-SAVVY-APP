import 'dart:ui';

import 'package:flight_savvy/view/chatwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stroke_text/stroke_text.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0 * scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(30 * scale),
              Text(
                'Hi,\n${widget.username}!',
                style: TextStyle(
                  fontSize: 70 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              Gap(20 * scale),
              Center(
                child: Text(
                  'Welcome to FlySavvy',
                  style: TextStyle(
                    fontSize: 32 * scale,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey[600],
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
