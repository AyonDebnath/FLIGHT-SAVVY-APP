import 'package:flutter/material.dart';

class Sustainability extends StatefulWidget {
  const Sustainability({Key? key}) : super(key: key);

  @override
  _SustainabilityState createState() => _SustainabilityState();
}

class _SustainabilityState extends State<Sustainability> {
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
                      'Sustainability',
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
            builder: (context) => SustainabilityDetails(title: title, text: text),
          ),
        );
      },
    );
  }
}

class SustainabilityDetails extends StatelessWidget {
  final String title;
  final String text;

  const SustainabilityDetails({Key? key, required this.title, required this.text})
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
          style: const TextStyle(
              fontSize: 25.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
