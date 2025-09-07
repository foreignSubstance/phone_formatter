import 'package:flutter/material.dart';
import 'package:phone_formatter/providers/phone_provider.dart';
import 'package:phone_formatter/providers/picked_country_provider.dart';
import 'package:phone_formatter/screens/main_screen.dart';
import 'package:phone_formatter/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const PhoneFormatterApp()));
}

class PhoneFormatterApp extends StatelessWidget {
  const PhoneFormatterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      home: Scaffold(
        body: MainScreen(),
        floatingActionButton: CustomFloatingActionButton(),
      ),
    );
  }
}

class CustomFloatingActionButton extends ConsumerWidget {
  const CustomFloatingActionButton({super.key});

  Future<void> showConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Well done'),
        content: Text('All set'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('ok', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPhoneValid = ref.watch(isPhoneValidProvider);
    final isCountryPicked = ref.watch(pickedCountryProvider) != null;

    final isValid = isPhoneValid && isCountryPicked;

    return FloatingActionButton(
      elevation: 0,
      onPressed: isValid ? () => showConfirmationDialog(context) : null,
      backgroundColor: isValid
          ? Colors.white
          : Theme.of(context).colorScheme.primary,
      child: Icon(
        Icons.arrow_forward,
        color: isValid
            ? Theme.of(context).colorScheme.secondary
            : Color(0xff7886B8),
      ),
    );
  }
}
