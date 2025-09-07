import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_formatter/formatter.dart';
import 'package:phone_formatter/providers/phone_provider.dart';

class PhoneWidget extends ConsumerWidget {
  const PhoneWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme.bodyMedium;
    return Expanded(
      child: TextField(
        onChanged: (value) => ref.read(phoneProvider.notifier).state = value,
        cursorColor: textTheme!.color,
        autofocus: true,
        style: textTheme,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          hint: Text(
            '(123) 123-1234',
            style: textTheme.copyWith(color: Color(0xFF7886B8)),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          CustomPhoneFormatter(),
          LengthLimitingTextInputFormatter(14),
        ],
      ),
    );
  }
}
