import 'package:flutter/material.dart';
import '../model/trip.dart';

class yourTrips extends StatelessWidget {
  final List<tripItem> tripItems = [
    tripItem(
      heading: 'Dec 30, 2024 : YYT To YYZ',
      description:'6:00am to 8:05am\n \nPrice : 105.70\n\n3 hours 56 minutes',
    ),
    tripItem(
      heading: 'Feb 14, 2024 : BOM To DEL',
      description:'5:00am to 7:26am\n \nPrice : 105.70\n\n2 hours 5 minutes',
    ),
    tripItem(
      heading: 'Dec 16, 2023 : ZYL To DAC\nJan 16, 2023 : DAC To ZYL',
      description:'11:20am to 12:00pm , 7:45 pm to 8:30 pm\n \nPrice : 298.60\n\n40 minutes, 45 minutes',
    ),
    // Add more FAQ items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Trips'),
      ),
      body: ListView.builder(
        itemCount: tripItems.length,
        itemBuilder: (context, index) {
          return tripsItemWidget(tripItems[index]);
        },
      ),
    );
  }
}

class tripsItemWidget extends StatefulWidget {
  final tripItem;

  tripsItemWidget(this.tripItem);

  @override
  _tripsItemWidgetState createState() => _tripsItemWidgetState();
}

class _tripsItemWidgetState extends State<tripsItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      child: ExpansionTile(
        title: Text(
          widget.tripItem.heading,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.tripItem.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Icon(
            Icons.delete,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
