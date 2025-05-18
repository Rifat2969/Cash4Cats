import 'package:flutter/material.dart';

class CountryListWidget extends StatelessWidget {
  const CountryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Text("🇺🇸"),
          title: const Text("United States"),
          onTap: () => Navigator.pop(context, {"name": "United States", "flag": "🇺🇸"}),
        ),
        ListTile(
          leading: const Text("🇪🇸"),
          title: const Text("Spain"),
          onTap: () => Navigator.pop(context, {"name": "Spain", "flag": "🇪🇸"}),
        ),
        ListTile(
          leading: const Text("🇫🇷"),
          title: const Text("France"),
          onTap: () => Navigator.pop(context, {"name": "France", "flag": "🇫🇷"}),
        ),
        ListTile(
          leading: const Text("🇩🇪"),
          title: const Text("Germany"),
          onTap: () => Navigator.pop(context, {"name": "Germany", "flag": "🇩🇪"}),
        ),
        ListTile(
          leading: const Text("🇮🇹"),
          title: const Text("Italy"),
          onTap: () => Navigator.pop(context, {"name": "Italy", "flag": "🇮🇹"}),
        ),
        ListTile(
          leading: const Text("🇷🇺"),
          title: const Text("Russia"),
          onTap: () => Navigator.pop(context, {"name": "Russia", "flag": "🇷🇺"}),
        ),
      ],
    );
  }
}
