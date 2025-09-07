import 'package:flutter/material.dart';
import 'package:phone_formatter/widgets/country_widget.dart';
import 'package:phone_formatter/widgets/phone_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 20, right: 20, top: 80),
      children: [
        Text('Get Started', style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 160),
        Row(children: [CountryWidget(), SizedBox(width: 8), PhoneWidget()]),
      ],
    );
  }
}
