import 'package:flutter/material.dart';

class WhyChooseUs extends StatefulWidget {
  const WhyChooseUs({Key? key}) : super(key: key);

  @override
  _WhyChooseUsState createState() => _WhyChooseUsState();
}

class _WhyChooseUsState extends State<WhyChooseUs> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.zero,
          elevation: 1,
          dividerColor: Colors.transparent,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          children: [
            ExpansionPanel(
              isExpanded: _isExpanded,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return const ListTile(
                  title: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Why FlySavvy?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                );
              },
              body: _buildClickableCard(
                title: 'Why FlySavvy?',
                text:
                '...',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClickableCard({
    required String text,
    required String title,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WhyChooseUsDetails(title: title, text: text),
          ),
        );
      },
    );
  }
}

class WhyChooseUsDetails extends StatelessWidget {
  final String title;
  final String text;

  const WhyChooseUsDetails({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
