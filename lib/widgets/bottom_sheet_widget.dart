import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_formatter/providers/fetched_data_provider.dart';
import 'package:phone_formatter/providers/filtered_data_provider.dart';
import 'package:phone_formatter/providers/picked_country_provider.dart';
import 'package:phone_formatter/providers/search_provider.dart';

class BottomSheetWidget extends ConsumerStatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  ConsumerState<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends ConsumerState<BottomSheetWidget> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref.read(searchProvider.notifier).state = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataList = ref.watch(fetchedDataProvider);
    final filteredCountries = ref.watch(filteredDataProvider);

    final content = Expanded(
      child: dataList.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Oops, something went wrong. $error')),
        data: (dataMap) {
          return ListView.builder(
            itemCount: filteredCountries.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () {
                ref.read(pickedCountryProvider.notifier).state =
                    filteredCountries[i];
                Navigator.pop(context);
              },
              child: CountryCard(
                name: filteredCountries[i].name,
                code: filteredCountries[i].code,
                flagUrl: filteredCountries[i].flag,
              ),
            ),
          );
        },
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 16),
          Header(),
          SizedBox(height: 20),
          SearchField(controller: _searchController),
          SizedBox(height: 12),
          content,
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Country code', style: Theme.of(context).textTheme.titleLarge),
        CloseSheetButton(),
      ],
    );
  }
}

class CloseSheetButton extends StatelessWidget {
  const CloseSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          Icons.close,
          color: Theme.of(context).textTheme.bodyMedium!.color,
          size: 16,
        ),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyMedium;
    return TextField(
      controller: controller,
      cursorColor: textTheme!.color,
      style: textTheme,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hint: Text('Search', style: textTheme),
        prefixIcon: Icon(Icons.search_rounded),
        prefixIconColor: textTheme.color,
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  const CountryCard({
    super.key,
    required this.name,
    required this.code,
    required this.flagUrl,
  });
  final String name;
  final String code;
  final String flagUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyMedium;
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 20,
            child: SvgPicture.network(flagUrl, fit: BoxFit.fill),
          ),
          SizedBox(width: 16),
          Text(code, style: textTheme),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              maxLines: 2,
              style: textTheme!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
