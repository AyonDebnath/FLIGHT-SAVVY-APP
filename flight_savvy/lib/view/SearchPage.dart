import 'package:flight_savvy/view/passengerView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/passengerList.dart';
import 'SearchBoxCollapsed.dart';
import '/controller/controller.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'flightList.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class SearchPage extends StatefulWidget {
  final Map<String, List<String>>? data;

  const SearchPage(this.data, {super.key});

  @override
  State<SearchPage> createState() => HomePageState();
}

class HomePageState extends State<SearchPage> {
  var cont = controller();
  bool doShow = false;
  int SelectVal = 0;
  int selectedStops = 0;
  List<String> texts = ['One way', 'Round trip'];
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();
  String? selectedOption1;
  String? selectedOption2;
  bool isBool = false;
  bool isOneWay = true;
  bool isNonStop = false;
  var formkey = GlobalKey<FormState>();

  /* Future<List<Map<String, dynamic>>> getFlights() async {
    List<Map<String, dynamic>> data = await cont.getDate(
        'BOS', 'LAX', true, DateTime.now(), DateTime.now(), 2);
    return data;
  } */

  void getData() {
    print(isBool);
    setState(() {
      isBool = true;
    });
  }

  void back() {
    print('reverted');
    setState(() {
      isBool = false;
    });
  }

  _selectPassenger(BuildContext context) => TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OpenPassengerList(),
          ),
        );
      },
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Icon(Icons.person, size: 40, color: Colors.amberAccent),
        ),
        title: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "\nSelect Passenger            ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 200,
                    child: Consumer<ItemViewModel>(
                        builder: (context, item, child) {
                          return FutureBuilder(
                              future: item.readPassengerValue(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data != null) {
                                    return ListView.separated(
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        String key =
                                        snapshot.data.keys.elementAt(index);
                                        return Text(
                                          "${snapshot.data[key]} $key ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                          Divider(
                                            color: Colors.amberAccent,
                                            thickness: 1,
                                          ),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                } else {
                                  return CircularProgressIndicator();
                                }
                              });
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> conts = [
      TextEditingController(text: selectedOption1),
      TextEditingController(text: selectedOption2),
      TextEditingController(text: DateFormat('yyyy-MM-dd').format(startDate!)),
      TextEditingController(text: DateFormat('yyyy-MM-dd').format(endDate!)),
    ];

    Map<String, List<String>>? data = widget.data;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('lib/assets/airplane background.png'))),
        child: Column(
          children: isBool == true
              ? [
                  const Gap(50),
                  Container(
                    child: SearchBoxCollapsed(
                      departure: selectedOption1,
                      destination: selectedOption2,
                      departureDate:
                          DateFormat('yyyy-MM-dd').format(startDate!),
                      returnDate: DateFormat('yyyy-MM-dd').format(endDate!),
                      isOneway: isOneWay,
                      back: back,
                    ),
                  ),
                  Expanded(
                      child: FlightList(isBool, [
                    selectedOption1,
                    selectedOption2,
                    isOneWay,
                    DateFormat('yyyy-MM-dd').format(startDate!),
                    DateFormat('yyyy-MM-dd').format(endDate!),
                    isNonStop = true,
                    selectedStops
                  ]))
                ]
              : [
                  const Gap(50),
                  Container(
                    width: 200,
                    height: 50,
                    child: AnimatedToggleSwitch<int>.rolling(
                      current: SelectVal,
                      values: [0, 1],
                      indicatorSize: const Size.fromWidth(100),
                      onChanged: (i) => setState(() => SelectVal = i),
                      iconBuilder: (SelectVal, bool) {
                        return Text(texts[SelectVal]);
                      },
                    ),
                  ),
                  const Gap(50),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 300,
                      width: 500,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        color: Colors.green[100],
                      ),
                      child: SingleChildScrollView(

                        child: Form(
                          key: formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TypeAheadFormField<String>(
                                validator: (value) {
                                  if (startDate == null || value!.isEmpty) {
                                    print(value);
                                    return 'Please Enter departure airport';
                                  }
                                  print(value);
                                  return null;
                                },
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: conts[0],
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      labelText: 'Where From ?',
                                      labelStyle: const TextStyle(
                                          fontFamily: 'nunito',
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w100)),
                                ),
                                suggestionsCallback: (pattern) async {
                                  return data!.keys.where((val) =>
                                      '$val${data[val]?.elementAt(0)}${data[val]?.elementAt(1)}'
                                          .toLowerCase()
                                          .contains(pattern.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(
                                        '$suggestion${data?[suggestion]?.elementAt(0)}${data![suggestion]?.elementAt(1)}'),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  setState(() {
                                    selectedOption1 =
                                        data![suggestion]!.elementAt(1);
                                  });
                                },
                              ),
                              const Gap(10),
                              TypeAheadFormField<String>(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter destination airport';
                                  }
                                  return null;
                                },
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: conts[1],
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      labelText: 'Where to ?',
                                      labelStyle: const TextStyle(
                                          fontFamily: 'nunito',
                                          fontSize: 25,
                                          color: Colors.black)),
                                ),
                                suggestionsCallback: (pattern) async {
                                  return data!.keys.where((val) =>
                                      '$val${data[val]?.elementAt(0)}${data[val]?.elementAt(1)}'
                                          .toLowerCase()
                                          .contains(pattern.toLowerCase()));
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(
                                        '$suggestion${data?[suggestion]?.elementAt(0)}${data![suggestion]?.elementAt(1)}'),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  setState(() {
                                    selectedOption2 =
                                        data![suggestion]!.elementAt(1);
                                  });
                                },
                              ),

                              // First row
                              Row(
                                children: [
                                  // Date Picker 1
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: conts[2],
                                        validator: (value) {
                                          if (startDate == null) {
                                            print(startDate);
                                            return 'Required departure date';
                                          }
                                          print(startDate);
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            icon: Icon(
                                                Icons.calendar_month_outlined),
                                            labelText: 'Start Date'),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2101),
                                          );
                                          if (pickedDate != null &&
                                              pickedDate != startDate) {
                                            setState(() {
                                              startDate = pickedDate;
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  // Date Picker 2
                                  Expanded(
                                    child: SelectVal == 0
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: conts[3],
                                              validator: (value) {
                                                if (endDate == null) {
                                                  return 'Required return date';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  icon: Icon(Icons
                                                      .calendar_month_outlined),
                                                  labelText: 'end Date'),
                                              readOnly: true,
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2101),
                                                );
                                                if (pickedDate != null &&
                                                    pickedDate != endDate) {
                                                  setState(() {
                                                    endDate = pickedDate;
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                  ),
                                  // Selection Box 1
                                ],
                              ),
                              // Second row

                              // DropdownButton for selecting the number of stops
                              DropdownButton<bool>(
                                value: isNonStop,
                                items: const [
                                  DropdownMenuItem<bool>(
                                    value: true,
                                    child: Text('Non-Stop'),
                                  ),
                                  DropdownMenuItem<bool>(
                                    value: false,
                                    child: Text('Any number of stops'),
                                  ),
                                ],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    isNonStop = newValue!;
                                  });
                                },
                                hint: const Text('Select Stops'),
                              ),



                              // Submit Button
                              ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    print("validated");
                                    return getData();
                                  }
                                },
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.blueAccent),
                                    fixedSize: MaterialStatePropertyAll(
                                        Size.fromWidth(116))),
                                child: const Row(children: [
                                  Icon(
                                    Icons.search_rounded,
                                    size: 23,
                                  ),
                                  Text(
                                    'Explore',
                                    style: TextStyle(
                                        fontFamily: 'RobotoC', fontSize: 20),
                                  )
                                ]),
                              ),
                              _selectPassenger(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
        ),
      ),
    );
  }
}
