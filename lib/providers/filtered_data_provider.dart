import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_formatter/models/country_model.dart';
import 'package:phone_formatter/providers/fetched_data_provider.dart';
import 'package:phone_formatter/providers/search_provider.dart';

final filteredDataProvider = Provider<List<Country>>((ref) {
  final fetchedData = ref.watch(fetchedDataProvider).value;
  final searchRequest = ref.watch(searchProvider).toLowerCase();

  if (fetchedData == null) return [];

  final filteredData = fetchedData.values.toList();

  if (searchRequest.isEmpty) return filteredData;

  return filteredData.where((country) {
    final name = country.name.toLowerCase();
    final code = country.code.toLowerCase();
    return name.contains(searchRequest) || code.contains(searchRequest);
  }).toList();
});
