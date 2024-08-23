import 'package:flutter/material.dart';

class CountryDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> countryData;

  const CountryDetailsDialog({super.key, required this.countryData});

  @override
  Widget build(BuildContext context) {
    final languages = (countryData['languages'] as Map).values.join(", ");
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(countryData['flags']['png']),
            ),
            const SizedBox(height: 16),
            Text("Name: ${countryData['name']['common']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Capital: ${countryData['capital'].first}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Population: ${countryData['population']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Languages: $languages", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}