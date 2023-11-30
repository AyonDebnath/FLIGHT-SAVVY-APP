import 'dart:ui';

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
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.black,
        Color.fromARGB(255, 114, 114, 114),
        Color.fromARGB(70, 7, 7, 7)
      ])),
      child: Column(
        children: [
          const Gap(70),
          Center(
            child: StrokeText(
              strokeWidth: 2.0,
              text: 'Hi,\n${widget.username}!',
              textStyle: const TextStyle(
                  fontFamily: 'OverpassM',
                  fontSize: 100,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200),
            ),
          ),
          const Gap(20),
          const Center(
            child: StrokeText(
              text: 'Welcome to flySavvy',
              strokeWidth: 2.0,
              textStyle: TextStyle(
                fontFamily: 'OverpassM',
                fontSize: 32,
              ),
            ),
          ),
          const Gap(20),
          Container(
            width: 340,
            height: 300,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 76, 20, 86),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: const Center(
              child: Text(
                "Travel suggestion chatbot! To be implemented",
                style: TextStyle(color: Colors.cyanAccent),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          )
        ],
      ),
    );
  }
}
