import 'dart:convert';
import 'dart:io';
import 'package:dart_openai/dart_openai.dart';
import 'package:http/http.dart' as http;

class ChatBotCont {
  HttpClient client = HttpClient();
  ChatBotCont() {
    OpenAI.apiKey = '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';
  }

  Future<String> Chat(String message) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content":
                "You are a flight travel assistant that answers in less than 150 words",
          },
          {
            "role": "user",
            "content": message,
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final reply = data['choices'][0]['message']['content'];

      return reply;
    } else {
      return "We're unable to process requests at the moment${response.statusCode}, ${response.reasonPhrase}";
    }
  }
}
