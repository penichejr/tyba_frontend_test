import 'package:flutter/material.dart';

import '../university_repository.dart';
import '../data/models/university.dart';
import 'universities_list_view.dart';
import 'universities_grid_view.dart';

class UniversitiesPage extends StatefulWidget {
  final UniversityRepository repository;

  const UniversitiesPage({super.key, required this.repository});

  @override
  State<UniversitiesPage> createState() => _UniversitiesPageState();
}

class _UniversitiesPageState extends State<UniversitiesPage> {
  int _currentIndex = 0;
  late Future<List<University>> _futureUniversities;

  @override
  void initState() {
    super.initState();
    _futureUniversities = widget.repository.getUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Universities',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true, 
        backgroundColor: const Color(
          0xFF0D47A1,
        ), 
        elevation: 0, 
        iconTheme: const IconThemeData(
          color: Colors.white, 
        ),
      ),
      body: FutureBuilder<List<University>>(
        future: _futureUniversities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          final universities = snapshot.data!;

          return _currentIndex == 0
              ? UniversitiesListView(universities: universities)
              : UniversitiesGridView(universities: universities);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Grid'),
        ],
      ),
    );
  }
}
