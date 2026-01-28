import 'package:flutter/material.dart';
import '../data/models/university.dart';
import 'university_detail_page.dart';

class UniversitiesListView extends StatelessWidget {
  final List<University> universities;

  const UniversitiesListView({super.key, required this.universities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: universities.length,
      itemBuilder: (context, index) {
        final u = universities[index];

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.school),
            title: Text(u.name),
            subtitle: Text(u.country),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UniversityDetailPage(university: u),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
