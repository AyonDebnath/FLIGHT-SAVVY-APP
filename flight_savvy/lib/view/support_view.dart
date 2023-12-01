import 'package:flutter/material.dart';
import 'FAQ_view.dart';
import 'contactUs_view.dart';

class support extends StatefulWidget {
  const support({super.key});

  @override
  State<support> createState() => _supportState();
}

class _supportState extends State<support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ), // Set the preferred size of the underline
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
            Navigator.of(context).pop();
          },
        ),
      ),
      body: CardList(),
    );
  }
}


class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildClickableCard(
          title: 'FAQ',
          subtitle: '',
          color: Colors.white,
          index: 0,
          context: context
        ),
        _buildClickableCard(
          title: 'Contact Us',
          subtitle: '',
          color: Colors.white,
          index: 1,
          context: context
        ),
      ],
    );
  }

  Widget _buildClickableCard({required String title, required String subtitle, required Color color, required int index, required context}) {
    // make the text bold for FAQ
    if(index ==0 ){
      return GestureDetector(
        onTap: () {

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => FAQScreen()),
              );
        },
        child: Card(
          elevation: 5.0,
          margin: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
    }



    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ContactUs()),
        );
      },
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
