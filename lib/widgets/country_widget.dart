import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_formatter/providers/picked_country_provider.dart';
import 'package:phone_formatter/theme.dart';
import 'package:phone_formatter/widgets/bottom_sheet_widget.dart';

class CountryWidget extends ConsumerWidget {
  const CountryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(pickedCountryProvider);
    final content = provider != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 20,
                child: SvgPicture.network(provider.flag, fit: BoxFit.fill),
              ),
              SizedBox(width: 4),
              Text(provider.code),
            ],
          )
        : Icon(Icons.arrow_drop_down);
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          backgroundColor: defaultTheme.scaffoldBackgroundColor,
          builder: (context) {
            return BottomSheetWidget();
          },
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: 71,
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: content,
      ),
    );
  }
}
