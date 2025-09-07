import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:phone_formatter/models/country_model.dart';

final fetchedDataProvider = FutureProvider((ref) async {
  Map<String, Country> countryList = {};
  try {
    var urlToProcess =
        'https://restcountries.com/v3.1/all?fields=name,idd,flags';

    var url = Uri.tryParse(urlToProcess);

    if (url == null) {
      throw Exception('Not valid url.');
    }

    var response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Status code ${response.statusCode}');
    }

    final data = json.decode(response.body) as List<dynamic>;
    for (final item in data) {
      final country = Country.fromJson(item as Map<String, dynamic>);
      countryList[country.name.toLowerCase()] = country;
    }
    return countryList;
  } catch (e) {
    throw Exception('Issue during fetching countries: $e');
  }
});
