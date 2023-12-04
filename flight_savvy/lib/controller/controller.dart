import 'dart:convert';
import 'package:flight_savvy/main.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:url_launcher/url_launcher.dart';

class controller {
  var Client = http.Client();
  var access_token;
  var assets = rootBundle;
  controller() {}

  Future<void> setToken() async {
    const clientId = 'iC4C1tpTShbup95uODppQ9GhrGIgkyJR';
    const clientSecret = '7YOrHgCDAAzEGvrk';
    final url =
    Uri.parse('https://test.api.amadeus.com/v1/security/oauth2/token');

    final response = await Client.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'client_credentials',
        'client_id': clientId,
        'client_secret': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      access_token = data['access_token'];
    } else {
      print('Error: ${response.statusCode}');
      print(response.body);
      return;
    }
  }

  Future<void> RedirectSkyScanner(String Url) async {
    final Uri url = Uri.parse(Url);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<List<List<List<dynamic>>>> getDate(String origin, String destination,
      bool isOneway, String leave, String retur, bool isNonStop) async {
    int count = 0;

    int stops = 0;
    print('isNONSTOP : $isNonStop');

    if (isOneway == true) {
      retur = '';
    }
    while (count <= 2) {
      try {
        var headers = {'authorization': 'Bearer $access_token'};

        var params = {
          'originLocationCode': '${origin.substring(0, 3)}',
          'destinationLocationCode': '${destination.substring(0, 3)}',
          'departureDate': '$leave',
          'returnDate': '$retur',
          'adults': '1',
          'children': '0',
          'infants': '0',
          'travelClass': 'ECONOMY',
          'max': '40',
          'currencyCode': MyApp.selectedCurrency,
          'nonStop': '$isNonStop'
        };

        var url =
        Uri.parse('https://test.api.amadeus.com/v2/shopping/flight-offers')
            .replace(queryParameters: params);
        var res = await Client.get(url, headers: headers);
        if (res.statusCode != 200) {
          throw Exception(
              'http.post error: statusCode=$res ${res.reasonPhrase}');
        }
        var res2 = json.decode(res.body) as Map<String, dynamic>;
        List<Map<String, dynamic>> allFlight = await toMap(await res2["data"]);

        int stopsCount = 0;

        // Filter flights based on the number of stops
        List<Map<String, dynamic>> filteredFlights = allFlight.where((flight) {
          List<dynamic> segments = flight['itineraries'][0]['segments'];

          stopsCount = segments.length - 1;

          return stopsCount == stops;
        }).toList();
        if (isNonStop == true) {
          var extracted = await extractFlightData(filteredFlights, isOneway);

          return extracted;
        } else {
          var extracted = await extractFlightData(allFlight, isOneway);
          return extracted;
        }
      } catch (e, stacktrace) {
        await setToken();
        count++;
      }
    }
    return [];
  }

  Future<Map<String, List<String>>> getAirports() async {
    const filePath = 'lib/assets/airpots.csv';
    Map<String, List<String>> airports = <String, List<String>>{};

    // Read the CSV file
    var file = await assets.loadString(filePath);

    List<String> listSplit = file.split('\n');
    List<List<String>> listF = listSplit.map((e) => e.split(',')).toList();
    for (int i = 0; i < listF.length; i++) {
      var e = listF[i];

      if (i == 8882) {
        break;
      }
      await airports.putIfAbsent(e[0], () => [e[1], e[2]]);
    }

    return airports;
  }
}

Future<List<Map<String, dynamic>>> toMap(List<dynamic> vals) async {
  List<Map<String, dynamic>> mapList = [];

  for (var item in vals) {
    if (item is Map<String, dynamic>) {
      item.removeWhere((key, value) => key != 'itineraries' && key != 'price');
      mapList.add(item);
    } else {}
  }
  return mapList;
}

List<List<List<dynamic>>> extractFlightData(
    List<Map<String, dynamic>> jsonData, bool isoneway) {
  List<List<List<dynamic>>> result = [];

  for (int i = 0; i < jsonData.length; i++) {
    List<List<dynamic>> tempRes = [];
    try {
      Map<String, dynamic> flightData = jsonData[i];
      Map<String, dynamic> firstItinerary = flightData['itineraries'][0];
      List<dynamic> segments = firstItinerary['segments'];
      Map<String, dynamic> firstSegment = segments[0];
      Map<String, dynamic> lastSegment = segments.last;
      Map<String, dynamic> price = flightData['price'];

      var SegList = [];
      for (Map<String, dynamic> segment in segments) {
        Map<String, dynamic> departure = segment['departure'];
        Map<String, dynamic> arrival = segment['arrival'];
        Map<String, dynamic> aircraft = segment['aircraft'];

        SegList.add([
          departure['iataCode'],
          departure['at'],
          arrival['iataCode'],
          arrival['at'],
          segment['duration'],
          // Arrival Airport IATA code
          // Arrival Airport Name
          // Departure Airport Name
          segment['carrierCode'], // Carrier Code
          aircraft['code'], // Aircraft Code
          segment['number'], // Aircraft Number
        ]);
      }
      tempRes.add([
        firstItinerary['duration'],
        firstSegment['departure']['iataCode'],
        firstSegment['departure']['at'],
        lastSegment['arrival']['iataCode'],
        lastSegment['arrival']['at'],
        price['currency'],
        price['total'],
        SegList
      ]);

      if (isoneway == false) {
        var SegList2 = [];
        Map<String, dynamic> flightData2 = jsonData[i];
        Map<String, dynamic> firstItinerary2 = flightData2['itineraries'][1];
        List<dynamic> segments2 = firstItinerary2['segments'];
        Map<String, dynamic> firstSegment2 = segments2[0];
        Map<String, dynamic> lastSegment2 = segments2.last;
        Map<String, dynamic> price2 = flightData2['price'];

        for (Map<String, dynamic> segment in segments2) {
          Map<String, dynamic> departure2 = segment['departure'];
          Map<String, dynamic> arrival2 = segment['arrival'];
          Map<String, dynamic> aircraft2 = segment['aircraft'];

          SegList2.add([
            departure2['iataCode'],
            departure2['at'],
            arrival2['iataCode'],
            arrival2['at'],
            segment['duration'],
            // Arrival Airport IATA code
            // Arrival Airport Name
            // Departure Airport Name
            segment['carrierCode'], // Carrier Code
            aircraft2['code'], // Aircraft Code
            segment['number'], // Aircraft Number
          ]);

          tempRes.add([
            firstItinerary2['duration'],
            firstSegment2['departure']['iataCode'],
            firstSegment2['departure']['at'],
            lastSegment2['arrival']['iataCode'],
            lastSegment2['arrival']['at'],
            price2['currency'],
            price2['total'],
            SegList2
          ]);
        }
      }
      result.add(tempRes);
    } catch (e) {
      print('Error extracting flight data: $e');
    }
  }

  return result;
}


/*
{
            "type": "amadeusOAuth2Token",
            "username": "chaudharyrushi123@gmail.com",
            "application_name": "fly Savvy",
            "client_id": "iC4C1tpTShbup95uODppQ9GhrGIgkyJR",
            "token_type": "Bearer",
            "access_token": "nD82tAAJ6sYtHKgkbKL4EGNAVvT2",
            "expires_in": 1799,
            "state": "approved",
            "scope": ""
        }*/