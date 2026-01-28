class University {
  final String name;
  final String country;
  final String alphaTwoCode;
  final String? stateProvince;
  final List<String> domains;
  final List<String> webPages;

  // String? imagePath;
  // int? students;

  University({
    required this.name,
    required this.country,
    required this.alphaTwoCode,
    required this.domains,
    required this.webPages,
    this.stateProvince,
    // this.imagePath,
    // this.students,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      country: json['country'],
      alphaTwoCode: json['alpha_two_code'],
      stateProvince: json['state-province'],
      domains: List<String>.from(json['domains']),
      webPages: List<String>.from(json['web_pages']),
    );
  }
}
