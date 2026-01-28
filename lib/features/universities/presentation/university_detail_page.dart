import 'package:flutter/material.dart';
import '../data/models/university.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UniversityDetailPage extends StatefulWidget {
  final University university;

  const UniversityDetailPage({super.key, required this.university});

  @override
  State<UniversityDetailPage> createState() => _UniversityDetailPageState();
}

class _UniversityDetailPageState extends State<UniversityDetailPage> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source);
    if (picked == null) return;

    setState(() {
      _selectedImage = File(picked.path);
      widget.university.imagePath = picked.path;
    });
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera, color: Colors.blue),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.blue),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  final TextEditingController _studentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.university.imagePath != null) {
      _selectedImage = File(widget.university.imagePath!);
    }
  }

  @override
  void dispose() {
    _studentsController.dispose();
    super.dispose();
  }

  void _saveStudents() {
    final text = _studentsController.text.trim();

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

    setState(() {
      widget.university.students = value;
      _studentsController.text = value.toString(); 
    });

    _showMessage('Saved successfully ✅');
    FocusScope.of(context).unfocus();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final u = widget.university;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(u.name), centerTitle: true, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarjeta principal de información
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.school,
                            color: Colors.blue,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                u.name,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Chip(
                                avatar: const Icon(Icons.public, size: 16),
                                label: Text(u.country),
                                backgroundColor: Colors.blue.shade50,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    _buildInfoRow(
                      Icons.language,
                      'Domains',
                      u.domains.join(" • "),
                    ),
                    const Divider(height: 32),
                    _buildInfoRow(
                      Icons.web,
                      'Websites',
                      u.webPages.join(" • "),
                    ),
                    const Divider(height: 32),
                    _buildInfoRow(
                      Icons.people,
                      'Students',
                      u.students?.toString() ?? 'Not set',
                      color: u.students != null ? null : Colors.grey.shade700,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Img preview
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _selectedImage!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.image, size: 80, color: Colors.grey),
                    ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _showImageOptions,
                icon: const Icon(Icons.photo_camera),
                label: const Text('Upload image'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Tarjeta para editar estudiantes
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Students Number',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: _studentsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number of students',
                        prefixIcon: const Icon(Icons.people),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _saveStudents,
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    Color? color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blueGrey, size: 22),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: color ?? Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
