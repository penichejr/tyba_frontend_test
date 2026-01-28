import 'package:flutter/material.dart';
import '../data/models/university.dart';
import 'university_detail_page.dart';

class UniversitiesGridView extends StatelessWidget {
  final List<University> universities;

  const UniversitiesGridView({super.key, required this.universities});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: universities.length,
      itemBuilder: (context, index) {
        final u = universities[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UniversityDetailPage(university: u),
              ),
            );
          },
          child: Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      u.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(u.country),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
