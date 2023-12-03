import 'package:flight_savvy/controller/controller.dart';
import 'package:flight_savvy/view/flightCard.dart';
import 'package:flight_savvy/widgets/thick_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class flightSegmentDetails extends StatelessWidget {
  final String airline;
  final String flightNumber;
  final String departure;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  final String price;
  final String duration;
  final List<dynamic> segments;
  final bool isOneway;
  List<dynamic>? segments2;

  flightSegmentDetails(segments2,
      {required this.airline,
      required this.duration,
      required this.flightNumber,
      required this.departure,
      required this.destination,
      required this.departureTime,
      required this.arrivalTime,
      required this.price,
      required this.segments,
      required this.isOneway}) {
    this.segments2 = segments2;
  }

  final isColor = false;

  @override
  Widget build(BuildContext context) {
    // print('SEGMENTSSS::::         $segments2');
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
              itemCount: segments.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                //print(segments);
                if (index == segments.length - 1) {
                  // Last segment, handle accordingly
                  print('last');
                  return flightCardRet([
                    segments[index][4],
                    '2334',
                    segments[index][5],
                    segments[index][3],
                    segments[index][6],
                    segments[index][0].toString(),
                    segments[index][2].toString(),
                    segments[index][1],
                  ]);
                } else {
                  // Calculate layover time
                  DateTime currentSegmentArrivalTime =
                      DateTime.parse(segments[index][3]);
                  DateTime nextSegmentDepartureTime =
                      DateTime.parse(segments[index + 1][1]);
                  Duration layoverDuration = nextSegmentDepartureTime
                      .difference(currentSegmentArrivalTime);
                  String layoverTime =
                      '${layoverDuration.inHours}h ${layoverDuration.inMinutes.remainder(60)}m';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(5),
                      flightCardRet([
                        segments[index][4],
                        '243',
                        segments[index][5],
                        segments[index][3],
                        segments[index][6],
                        segments[index][0].toString(),
                        segments[index][2].toString(),
                        segments[index][1],
                      ]),

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
          segments2 == null || segments2!.isEmpty
              ? Gap(0)
              : Container(
                  height: 300,
                  width: 300,
                  child: Column(
                    children: [
                      Text(
                        'Return',
                        style: TextStyle(fontSize: 20),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: segments.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index == segments.length - 1) {
                              // Last segment, handle accordingly
                              print('last');
                              return flightCardRet([
                                segments2![index][4],
                                '2334',
                                segments2![index][5],
                                segments2![index][3],
                                segments2![index][6],
                                segments2![index][0].toString(),
                                segments2![index][2].toString(),
                                segments2![index][1],
                              ]);
                            } else {
                              // Calculate layover time
                              DateTime currentSegmentArrivalTime =
                                  DateTime.parse(segments[index][3]);
                              DateTime nextSegmentDepartureTime =
                                  DateTime.parse(segments[index + 1][1]);
                              Duration layoverDuration =
                                  nextSegmentDepartureTime
                                      .difference(currentSegmentArrivalTime);
                              String layoverTime =
                                  '${layoverDuration.inHours}h ${layoverDuration.inMinutes.remainder(60)}m';

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap(5),
                                  flightCardRet([
                                    segments2![index][4],
                                    '243',
                                    segments2![index][5],
                                    segments2![index][3],
                                    segments2![index][6],
                                    segments2![index][0].toString(),
                                    segments2![index][2].toString(),
                                    segments2![index][1],
                                  ]),

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
                    ],
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
                  print(isOneway);
                  controller().RedirectSkyScanner(
                      "https://www.skyscanner.ca/transport/flights/$departure/$destination/${DateFormat('yyMMdd').format(DateTime.parse(departureTime))}/${DateFormat('yyMMdd').format(DateTime.parse(arrivalTime!))}/?adultsv2=1&cabinclass=economy&childrenv2=&inboundaltsenabled=false&outboundaltsenabled=false&preferdirects=false&rtn=${isOneway ? 0 : 1}");
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
