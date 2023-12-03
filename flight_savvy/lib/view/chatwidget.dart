//API_KEY = v88bf6yhk4wd

import 'package:flight_savvy/controller/chatBot_controller.dart';
import 'package:flight_savvy/controller/controller.dart';
import 'package:flutter/material.dart';

class chatWidget extends StatefulWidget {
  @override
  State<chatWidget> createState() => chatState();
}

class chatState extends State<chatWidget> {
  TextEditingController cont = TextEditingController();
  List<Map<String, String>> messages = [];
  ChatBotCont chat_cont = ChatBotCont();
  bool isLoading = false;

  void chat(String userMsg) async {
    setState(() {
      messages.add({'message': userMsg, 'user': 'user'});
      messages.add({'message': 'Loading', 'user': 'chatBot'});
      isLoading = true;
    });

    String chatresp = await chat_cont.Chat(userMsg);
    messages.removeLast();
    print(chatresp);
    setState(() {
      messages.add({'message': chatresp, 'user': 'chatBot'});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Scale = (MediaQuery.of(context).size.height) / 1000;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10 * Scale, bottom: 10 * Scale),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                    left: (messages[index]['user'] == "user"
                        ? 14 * Scale
                        : 30 * Scale),
                    right: (messages[index]['user'] == "chatBot"
                        ? 14 * Scale
                        : 30 * Scale),
                    top: 10 * Scale,
                    bottom: 10 * Scale),
                child: Align(
                  alignment: (messages[index]['user'] == "user"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index]['user'] == "user"
                          ? Colors.grey.shade200
                          : const Color.fromRGBO(144, 202, 249, 1)),
                    ),
                    padding: messages[index]['message']! == "Loading"
                        ? EdgeInsets.all(0)
                        : const EdgeInsets.all(16),
                    child: messages[index]['message']! == "Loading"
                        ? Image(
                            height: 40,
                            width: 70,
                            image: AssetImage('assets/images/textLoading.gif'),
                          )
                        : Text(
                            messages[index]['message']!,
                            style: const TextStyle(
                                fontSize: 15, fontFamily: 'overpassM'),
                          ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: cont,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hintText: '    Type your message...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final userMessage = cont.text.trim();
                  chat(userMessage);
                  cont.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
