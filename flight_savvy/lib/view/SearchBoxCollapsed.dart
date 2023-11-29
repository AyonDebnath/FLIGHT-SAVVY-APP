import 'package:flutter/material.dart';
import '/widgets/thick_container.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '/utils/app_layout.dart';
import '/utils/app_styles.dart';

class SearchBoxCollapsed extends StatelessWidget {
  final String? departure;
  final String? destination;
  final String departureDate;
  final String? returnDate;
  //final Map<String, dynamic> info;
  final bool isOneway;
  final isColor = false;
  Function() back;

  SearchBoxCollapsed(
      {required this.departure,
      required this.destination,
      required this.departureDate,
      required this.returnDate,
      required this.isOneway,
      required this.back});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width,
      height: 150,
      child: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              color: Colors.amber[100],
              child: Row(
                children: [
                  IconButton(
                      onPressed: back, icon: const Icon(Icons.arrow_back)),
                  Gap(70),
                  const Center(
                    child: Text(
                      'Showing results',
                      style: TextStyle(fontFamily: 'RobotoC', fontSize: 23),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              decoration: BoxDecoration(
                color:
                    isColor == null ? const Color(0xFF526799) : Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(departure!,
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'nunito')),
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
                      Text(destination!,
                          style: const TextStyle(
                              fontSize: 18, fontFamily: 'nunito')),
                    ],
                  ),
                  const Gap(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          DateFormat('MMMMd')
                              .format(DateTime.parse(departureDate)),
                          style: isColor == null
                              ? Styles.headLineStyle4
                                  .copyWith(color: Colors.white)
                              : Styles.headLineStyle4,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          isOneway == false
                              ? DateFormat('MMMMd')
                                  .format(DateTime.parse(returnDate!))
                              : 'One Way',
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
