import 'package:flutter/material.dart';
import '../data/models/university.dart';

class UniversityDetailPage extends StatelessWidget {
  final University university;

  const UniversityDetailPage({super.key, required this.university});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(university.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.school, size: 40),
                const SizedBox(height: 16),

                Text(
                  university.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text('Country: ${university.country}'),

                const SizedBox(height: 8),

                Text('Domains: ${university.domains.join(", ")}'),

                const SizedBox(height: 8),

                Text('Web: ${university.webPages.join(", ")}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
