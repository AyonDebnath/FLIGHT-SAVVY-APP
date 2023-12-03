import 'package:flutter/material.dart';

class Expandables extends StatelessWidget {
  final String airline;
  final String flightNumber;
  final String departure;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final String price;
  final String duration;
  final List<dynamic> segments;
  List<dynamic>? segments2;

  Expandables(
    segments2,
      {required this.airline,
      required this.duration,
      required this.flightNumber,
      required this.departure,
      required this.destination,
      required this.departureTime,
      required this.arrivalTime,
      required this.price,
      required this.segments});

  String _getSegmentFlights() {
    List<String> details = [];
    for (var segment in this.segments) {
      for (var data in segment) {
        details.add(data.toString());
        // print(data[data.length - 1]);
      }
    }
    print(details[0]);
    return details.join(''); // Join the list elements into a single string
  }

  @override
  Widget build(BuildContext context) {
    print(segments);
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black12, Colors.black12],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Flight Details',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Icon(
                Icons.local_atm,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 16),
          FlightDetailItem(label: 'Flights', value: _getSegmentFlights()),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'CAD $price',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FlightDetailItem extends StatelessWidget {
  final String label;
  final String value;

  FlightDetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        Column(
          children: [
            Text(
              value, // Join the list elements into a single string
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
