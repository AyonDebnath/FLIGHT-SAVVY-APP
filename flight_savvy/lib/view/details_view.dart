import 'package:flutter/material.dart';
import 'user_info.dart';
import 'editInfo_view.dart';

class details extends StatefulWidget {
  const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your details'),
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
          title: 'User info',
          subtitle: '',
          color: Colors.white,
          index: 0,
          context: context,
        ),
        _buildClickableCard(
          title: 'Edit info',
          subtitle: '',
          color: Colors.white,
          index: 1,
          context: context,
        ),
        // Add more cards as needed
      ],
    );
  }

  Widget _buildClickableCard({required String title, required String subtitle, required Color color, required int index, required context}) {
    return GestureDetector(
      onTap: () {
        if(index == 0) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => userInfo()),
          );
        }
        if(index == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => editInfo()),
          );
        }
        print("index:$index pressed");
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
            // subtitle: Text(
            //   subtitle,
            //   style: TextStyle(
            //     color: Colors.black,
            //   ),
            // ),
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
