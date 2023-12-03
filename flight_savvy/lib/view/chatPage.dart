import 'dart:ui';

import 'package:flight_savvy/view/chatwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:stroke_text/stroke_text.dart';

class chatPage extends StatefulWidget {
  @override
  final String username;
  chatPage(this.username);
  State<chatPage> createState() => chatState();
}

class chatState extends State<chatPage> {
  
  @override
  Widget build(BuildContext context) {
    final Scale = (MediaQuery.of(context).size.height) / 838.4;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.black,
        Color.fromARGB(255, 114, 114, 114),
        Color.fromARGB(70, 7, 7, 7)
      ])),
      child: ListView(
        children: [
           Gap(30*Scale),
          Container(
            alignment: Alignment.topLeft,
            child: StrokeText(
              strokeWidth: 4.0,
              text: 'Hi,\n${widget.username}!',
              textStyle:  TextStyle(
                  fontFamily: 'OverpassM',
                  fontSize: 70*Scale,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200),
            ),
          ),
           Gap(20*Scale),
           Center(
            child: StrokeText(
              text: 'Welcome to flySavvy',
              strokeWidth: 2.0,
              textStyle: TextStyle(
                fontFamily: 'OverpassM',
                fontSize: 32*Scale,
              ),
            ),
          ),
           Gap(20*Scale),
          Padding(
            padding:  EdgeInsets.all(8.0 * Scale),
            child: Container(
              width: 340 * Scale,
              height: 400 * Scale,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF273238), // Darker shade of grey
                      Color(0xFF455A64), // Slightly lighter shade of grey
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Center(
                child: chatWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
