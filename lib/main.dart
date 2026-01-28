import 'package:flutter/material.dart';

import 'features/universities/university_repository.dart';
import 'features/universities/data/services/university_service.dart';

void main() {
  final repository = UniversityRepository(UniversityService());

  runApp(MaterialApp(home: DebugPage(repository: repository)));
}

class DebugPage extends StatefulWidget {
  final UniversityRepository repository;

  const DebugPage({super.key, required this.repository});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  void initState() {
    super.initState();
    _loadUniversities();
  }

  Future<void> _loadUniversities() async {
    try {
      final universities = await widget.repository.getUniversities();

      print('TOTAL: ${universities.length}');
      for (final u in universities.take(5)) {
        print('${u.name} - ${u.country}');
      }
    } catch (e) {
      print('ERROR: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Check console logs 👀')));
  }
}
