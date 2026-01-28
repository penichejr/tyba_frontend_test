import 'package:flutter/material.dart';
import '../data/models/university.dart';
import 'university_detail_page.dart';

class UniversitiesGridView extends StatelessWidget {
  final List<University> universities;

  const UniversitiesGridView({super.key, required this.universities});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.86, // ← un poco más alto para dar espacio vertical
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: universities.length,
      itemBuilder: (context, index) {
        final u = universities[index];

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UniversityDetailPage(university: u),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(
                12,
              ), // ← reducimos un poco el padding interno
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // ← importante
                children: [
                  // Icon circle
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.blue,
                      size: 28,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        u.name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13.5, // tamaño más seguro
                          fontWeight: FontWeight.w600,
                          height: 1.18, // interlineado controlado
                          letterSpacing: -0.1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Country badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      u.country,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
