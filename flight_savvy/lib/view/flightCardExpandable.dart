import 'package:flight_savvy/view/details_view.dart';
import 'package:flight_savvy/view/segmentFlights.dart';
import 'package:flight_savvy/widgets/thick_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Expandable extends StatelessWidget {
  final String airline;
  final String flightNumber;
  final String departure;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final String price;
  final String duration;
  final List<dynamic> segments;

  Expandable({
    required this.airline,
    required this.duration,
    required this.flightNumber,
    required this.departure,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.segments,
  });

  List<List<dynamic>> _getSegmentFlights() {
    List<List<dynamic>> details = [];
    for (var segment in this.segments) {
      for (var data in segment) {
        details.add(data);
        // print(data[data.length - 1]);
      }
    }
    // print(details);
    return details; // Join the list elements into a single string
  }

  final isColor = false;

  @override
  Widget build(BuildContext context) {
    print(segments);
    final List<List<dynamic>> segmentsList = _getSegmentFlights();
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
          Expanded(
            child: ListView.builder(
              itemCount: segmentsList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == segmentsList.length - 1) {
                  // Last segment, handle accordingly
                  return segmentFlightsCard(
                    duration: segmentsList[index][4],
                    airline: segmentsList[index][5],
                    arrivalTime: segmentsList[index][3],
                    flightNumber: segmentsList[index][7],
                    departure: segmentsList[index][0].toString(),
                    destination: segmentsList[index][2].toString(),
                    departureTime: segmentsList[index][1],
                  );
                } else {
                  // Calculate layover time
                  DateTime currentSegmentArrivalTime =
                      DateTime.parse(segmentsList[index][3]);
                  DateTime nextSegmentDepartureTime =
                      DateTime.parse(segmentsList[index + 1][1]);
                  Duration layoverDuration = nextSegmentDepartureTime
                      .difference(currentSegmentArrivalTime);
                  String layoverTime =
                      '${layoverDuration.inHours}h ${layoverDuration.inMinutes.remainder(60)}m';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(5),
                      segmentFlightsCard(
                        duration: segmentsList[index][4],
                        airline: segmentsList[index][5],
                        arrivalTime: segmentsList[index][3],
                        flightNumber: segmentsList[index][7],
                        departure: segmentsList[index][0].toString(),
                        destination: segmentsList[index][2].toString(),
                        departureTime: segmentsList[index][1],
                      ),

                      const Row(
                        children: [
                          SizedBox(
                            child: ThickContainer(),
                            width: 10,
                            height: 10,
                          ),
                        ],
                      ),
                      // const SizedBox(height: 8),
                      const Row(
                        children: [
                          SizedBox(
                            child: ThickContainer(),
                            width: 10,
                            height: 10,
                          ),
                        ],
                      ),
                      // const SizedBox(height: 8),
                      const Row(
                        children: [
                          SizedBox(
                            child: ThickContainer(),
                            width: 10,
                            height: 10,
                          ),
                        ],
                      ),
                      // const SizedBox(height: 8),
                      Row(
                        children: [
                          const SizedBox(
                            child: ThickContainer(),
                            width: 10,
                            height: 10,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Layover Time: $layoverTime',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Row(
                        children: [
                          SizedBox(
                            child: ThickContainer(),
                            width: 10,
                            height: 10,
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Row(
                        children: [
                          SizedBox(
                            child: ThickContainer(),
                            width: 10,
                            height: 10,
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),

                      const Row(
                        children: [
                          SizedBox(
                            child: ThickContainer(),
                            width: 10,
                            height: 10,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CAD $price',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  // Handle the button press
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Text(
                    'Select Flight',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
