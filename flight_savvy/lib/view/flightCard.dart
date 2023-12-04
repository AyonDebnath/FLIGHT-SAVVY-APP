import 'package:intl/intl.dart';

import '/utils/app_layout.dart';
import '/utils/app_styles.dart';
import '/widgets/thick_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FlightCard extends StatelessWidget {
  late String airline;
  late String flightNumber;
  late String departure;
  late String destination;
  late String departureTime;
  late String arrivalTime;
  //final Map<String, dynamic> info;
  late String price;
  late bool isColor;
  late String duration;

  FlightCard(List<dynamic> vals) {
    airline = vals[2];
    flightNumber = vals[4];
    departure = vals[5];
    destination = vals[6];
    departureTime = vals[7];
    arrivalTime = vals[3];

    price = vals[1];
    isColor = false;
    duration = vals[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width * 0.95,
      height: 135,
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: const Color(0xFF526799),
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            //showing the blue part of the ticket
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        departure,
                        style: isColor == null
                            ? Styles.headLineStyle3
                            .copyWith(color: Colors.white)
                            : Styles.headLineStyle3,
                      ),
                      Expanded(child: Container()),
                      ThickContainer(
                        isColor: isColor,
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 24,
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(
                                      (constraints.constrainWidth() / 6)
                                          .floor(),
                                          (index) => SizedBox(
                                        width: 3,
                                        height: 1,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: isColor == null
                                                  ? Colors.white
                                                  : Colors.grey.shade300),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Transform.rotate(
                                angle: 1.5,
                                child: Icon(
                                  Icons.local_airport_rounded,
                                  color: isColor == null
                                      ? Colors.white
                                      : const Color(0xff8accf7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ThickContainer(isColor: isColor),
                      Expanded(child: Container()),
                      Text(
                        destination,
                        style: isColor == null
                            ? Styles.headLineStyle3
                            .copyWith(color: Colors.white)
                            : Styles.headLineStyle3,
                      ),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          '${DateFormat('jm').format(DateTime.parse(departureTime))}',
                          style: isColor == null
                              ? Styles.headLineStyle4
                              .copyWith(color: Colors.white)
                              : Styles.headLineStyle4,
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        child: Text(
                          duration.substring(2),
                          style: isColor == null
                              ? Styles.headLineStyle3
                              .copyWith(color: Colors.white)
                              : Styles.headLineStyle3,
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        child: Text(
                          '${DateFormat('jm').format(DateTime.parse(arrivalTime))}',
                          textAlign: TextAlign.end,
                          style: isColor == null
                              ? Styles.headLineStyle4
                              .copyWith(color: Colors.white)
                              : Styles.headLineStyle4,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Text(
                      'CAD${NumberFormat.simpleCurrency(locale: 'en_CA', name: 'CAD').currencySymbol} $price',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'RobotoC',
                          color: Color.fromARGB(255, 40, 49, 54)),
                    ),
                  )
                ],
              ),
            ),

            //showing the orange part of the ticket

            //bottom part of orange part
          ],
        ),
      ),
    );
  }
}

class flightCardRet extends StatelessWidget {
  late String airline;
  late String flightNumber;
  late String departure;
  late String destination;
  late String departureTime;
  late String arrivalTime;
  //final Map<String, dynamic> info;
  late String price;
  late bool isColor;
  late String duration;

  flightCardRet(List<dynamic> vals) {
    airline = vals[2];
    flightNumber = vals[4];
    departure = vals[5];
    destination = vals[6];
    departureTime = vals[7];
    arrivalTime = vals[3];

    price = vals[1];
    isColor = false;
    duration = vals[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width * 0.95,
      height: 100,
      padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: const Color(0xFFF37B67),
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            //showing the blue part of the ticket
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(21),
                  topRight: Radius.circular(21),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        departure,
                        style: isColor == null
                            ? Styles.headLineStyle3
                            .copyWith(color: Colors.white)
                            : Styles.headLineStyle3,
                      ),
                      Expanded(child: Container()),
                      ThickContainer(
                        isColor: isColor,
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 24,
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: List.generate(
                                      (constraints.constrainWidth() / 6)
                                          .floor(),
                                          (index) => SizedBox(
                                        width: 3,
                                        height: 1,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: isColor == null
                                                  ? Colors.white
                                                  : Colors.grey.shade300),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Transform.rotate(
                                angle: 1.5,
                                child: Icon(
                                  Icons.local_airport_rounded,
                                  color: isColor == null
                                      ? Colors.white
                                      : const Color(0xff8accf7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ThickContainer(isColor: isColor),
                      Expanded(child: Container()),
                      Text(
                        destination,
                        style: isColor == null
                            ? Styles.headLineStyle3
                            .copyWith(color: Colors.white)
                            : Styles.headLineStyle3,
                      ),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${DateFormat('jm').format(DateTime.parse(departureTime))}',
                          style: isColor == null
                              ? Styles.headLineStyle4
                              .copyWith(color: Colors.white)
                              : Styles.headLineStyle4,
                        ),
                      ),
                      Text(
                        duration.substring(2),
                        style: isColor == null
                            ? Styles.headLineStyle3
                            .copyWith(color: Colors.white)
                            : Styles.headLineStyle3,
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${DateFormat('jm').format(DateTime.parse(arrivalTime))}',
                          textAlign: TextAlign.end,
                          style: isColor == null
                              ? Styles.headLineStyle4
                              .copyWith(color: Colors.white)
                              : Styles.headLineStyle4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //showing the orange part of the ticket

            //bottom part of orange part
          ],
        ),
      ),
    );
  }
}