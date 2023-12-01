import 'package:flutter/material.dart';
import '../model/FAQ.dart';

class FAQScreen extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'How do I search for flights?',
      answer: 'To search for flights, enter your departure and destination '
          'cities, select your travel dates, and click the search button.',
    ),
    FAQItem(
      question: 'Can I book a hotel through Skyscanner?',
      answer: 'We primarily focuses on flights. However, you can find '
          'links to booking websites in the search results which may help you find suitable hotels.',
    ),
    // Add more FAQ items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView.builder(
        itemCount: faqItems.length,
        itemBuilder: (context, index) {
          return FAQItemWidget(faqItems[index]);
        },
      ),
    );
  }
}

class FAQItemWidget extends StatefulWidget {
  final FAQItem faqItem;

  FAQItemWidget(this.faqItem);

  @override
  _FAQItemWidgetState createState() => _FAQItemWidgetState();
}

class _FAQItemWidgetState extends State<FAQItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ExpansionTile(
        title: Text(widget.faqItem.question, style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.faqItem.answer, style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),),
          ),
        ],
      ),
    );
  }
}