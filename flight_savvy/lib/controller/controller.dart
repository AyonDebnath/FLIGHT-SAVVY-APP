import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:csv/csv.dart';

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

  Future<List<List<dynamic>>> getDate(String origin, String destination,
      bool isOneway, String leave, String retur, bool isNonStop) async {
    int count = 0;
    print(origin);
    print(destination);
    print(leave);
    print(retur);
    int stops = 0;
    bool isNonStop = false;

    if (isOneway == true) {
      retur = '';
    }
    while (count <= 2) {
      try {
        var headers = {'authorization': 'Bearer $access_token'};

        var params = {
          'originLocationCode': '$origin',
          'destinationLocationCode': '$destination',
          'departureDate': '$leave',
          'returnDate': '$retur',
          'adults': '1',
          'children': '0',
          'infants': '0',
          'travelClass': 'ECONOMY',
          'max': '30',
          'currencyCode': 'CAD',
        };

        var url =
            Uri.parse('https://test.api.amadeus.com/v2/shopping/flight-offers')
                .replace(queryParameters: params);
        var res = await Client.get(url, headers: headers);
        if (res.statusCode != 200) {
          throw Exception(
              'http.post error: statusCode=${res.statusCode} ${res.reasonPhrase}');
        }
        var res2 = json.decode(res.body) as Map<String, dynamic>;
        List<Map<String, dynamic>> allFlight = await toMap(await res2["data"]);

        int stopsCount = 0;

        // Filter flights based on the number of stops
        List<Map<String, dynamic>> filteredFlights =
        allFlight.where((flight) {
          List<dynamic> segments = flight['itineraries'][0]['segments'];
          print(segments);
          stopsCount = segments.length - 1;
          print(stopsCount);
          // print(stopsCount == stops);

          return stopsCount == stops;
        }).toList();

        print(isNonStop);

        if (isNonStop == true) {
          var extracted = await extractFlightData(filteredFlights);
          print(extracted);
          return extracted;
        }
        else {
          var extracted = await extractFlightData(allFlight);
          print(extracted);
          return extracted;
        }


      } catch (e) {
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

    CsvToListConverter().convert(file).forEach((e) {
      airports.putIfAbsent(
          e[0].toString(), () => [e[1].toString(), e[2].toString()]);
    });

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

List<List<dynamic>> extractFlightData(List<Map<String, dynamic>> jsonData) {
  List<List<dynamic>> result = [];
  for (int i = 0; i < jsonData.length; i++) {
    try {
      Map<String, dynamic> flightData = jsonData[i];
      Map<String, dynamic> firstItinerary = flightData['itineraries'][0];
      List<dynamic> segments = firstItinerary['segments'];
      Map<String, dynamic> firstSegment = segments[0];
      Map<String, dynamic> lastSegment = segments.last;
      Map<String, dynamic> price = flightData['price'];

      result.add([
        firstItinerary['duration'],
        firstSegment['departure']['iataCode'],
        firstSegment['departure']['at'],
        lastSegment['arrival']['iataCode'],
        lastSegment['arrival']['at'],
        price['currency'],
        price['total'],
        segments.length,
        []
      ]);
      for (Map<String, dynamic> segment in segments) {
        Map<String, dynamic> departure = segment['departure'];
        Map<String, dynamic> arrival = segment['arrival'];
        Map<String, dynamic> aircraft = segment['aircraft'];

        result.last[8].add([
          departure['iataCode'],
          departure['at'],
          arrival['iataCode'],
          arrival['at'],
          segment['duration'],
          segment['carrierCode'], // Carrier Code
          aircraft['code'], // Aircraft Code
          segment['number'], // Aircraft Number
        ]);
      }
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