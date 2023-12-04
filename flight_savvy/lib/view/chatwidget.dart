import 'package:flutter/material.dart';
import 'package:flight_savvy/controller/chatBot_controller.dart';

class chatWidget extends StatefulWidget {
  @override
  State<chatWidget> createState() => _chatState();
}

class _chatState extends State<chatWidget> {
  TextEditingController cont = TextEditingController();
  List<Map<String, String>> messages = [];
  ChatBotCont chat_cont = ChatBotCont();

  void chat(String userMsg) async {
    if (userMsg.isEmpty) return;
    setState(() {
      messages.add({'message': userMsg, 'user': 'user'});
    });

    await Future.delayed(Duration(milliseconds: 500));
    String chatresp = await chat_cont.Chat(userMsg);
    setState(() {
      messages.add({'message': chatresp, 'user': 'chatBot'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: messages.isEmpty
              ? Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Image.asset('assets/chatbot.png', height: 100),
                  ),
                  Text(
                    "Hi there! I'm your ChatBot. How can I help you today?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
          )
              : ListView.builder(
            itemCount: messages.length,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            itemBuilder: (context, index) {
              bool isUserMessage = messages[index]['user'] == "user";
              return Align(
                alignment: isUserMessage ? Alignment.topLeft : Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isUserMessage ? Colors.grey.shade300 : Colors.lightBlue[200],
                  ),
                  child: Text(
                    messages[index]['message'] ?? "",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: cont,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.blue),
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
