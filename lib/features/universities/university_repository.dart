import 'data/models/university.dart';
import 'data/services/university_service.dart';

class UniversityRepository {
  final UniversityService _service;

  UniversityRepository(this._service);

  Future<List<University>> getUniversities() {
  return _service.fetchUniversities();
}

}

