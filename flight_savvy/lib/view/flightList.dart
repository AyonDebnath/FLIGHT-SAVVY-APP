import 'package:flutter/material.dart';
import '/controller/controller.dart';
import 'flightCard.dart';

class flightList extends StatelessWidget {
  List<dynamic> vals;

  bool toShow;
  controller cont = controller();
  flightList(this.toShow, this.vals);

  @override
  Widget build(BuildContext context) {
    print("$toShow in flightlistState");
    if (toShow == false) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: 10,
            width: 500,
            child: const Text(
              "",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
          ));
    } else {
      return Scaffold(
        body: FutureBuilder<List<List<dynamic>>>(
            future: cont.getDate(
                vals[0], vals[1], vals[2], vals[3], vals[4], vals[5]),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text(
                    'Fetching Flights ',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              List<List<dynamic>>? data = snapshot.data;

              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    var flight_instance = data[index];

                    return Center(
                      child: FlightCard(
                        duration: flight_instance[0],
                        price: flight_instance[6],
                        airline: 'Lufthansa',
                        arrivalTime: flight_instance[4],
                        flightNumber: '202131',
                        departure: flight_instance[1].toString(),
                        destination: flight_instance[3].toString(),
                        departureTime: flight_instance[2],
                      ),
                    );
                  });
            }),
      );
    }
  }
}


/*
data[
  [
    duration,
    segments[first]['departure']['iatacode'],
    segments[first]['departure']['at'],
    segments[last]['arrival']['iatacode'],
    segments[first]['arrival']['at'],
    price['Currency'],
    price['total'],
    segements.length,

  ]
]




*/ 