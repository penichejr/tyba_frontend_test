import 'package:flutter/material.dart';

import 'features/universities/university_repository.dart';
import 'features/universities/data/services/university_service.dart';
import 'features/universities/presentation/universities_page.dart';

void main() {
  final repository = UniversityRepository(UniversityService());

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UniversitiesPage(repository: repository),
    ),
  );
}
