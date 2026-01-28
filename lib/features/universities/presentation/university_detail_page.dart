import 'package:flutter/material.dart';
import '../data/models/university.dart';

class UniversityDetailPage extends StatefulWidget {
  final University university;

  const UniversityDetailPage({super.key, required this.university});

  @override
  State<UniversityDetailPage> createState() => _UniversityDetailPageState();
}

class _UniversityDetailPageState extends State<UniversityDetailPage> {
  final TextEditingController _studentsController = TextEditingController();

  @override
  void dispose() {
    _studentsController.dispose();
    super.dispose();
  }

  void _saveStudents() {
    final text = _studentsController.text.trim();

    //StudentsValidations
    if (text.isEmpty) {
      _showMessage('Please enter number of students');
      return;
    }

    final value = int.tryParse(text);

    if (value == null) {
      _showMessage('Students must be a valid number');
      return;
    }

    if (value <= 0) {
      _showMessage('Students must be greater than 0');
      return;
    }

    //SaveStudents
    setState(() {
      widget.university.students = value;
    });

    _showMessage('Saved successfully ✅');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final university = widget.university;

    return Scaffold(
      appBar: AppBar(title: Text(university.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Card info
                const Icon(Icons.school, size: 40),
                const SizedBox(height: 12),

                Text(
                  university.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),
                Text('Country: ${university.country}'),
                Text('Domains: ${university.domains.join(", ")}'),
                Text('Web: ${university.webPages.join(", ")}'),
                Text('Students: ${university.students ?? "Not set"}'),

                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),

                //Img preview
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(Icons.image, size: 60, color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Upload image'),
                  ),
                ),

                const SizedBox(height: 20),

                //Student input
                TextField(
                  controller: _studentsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Number of students',
                    prefixIcon: const Icon(Icons.people),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Save button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveStudents,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
