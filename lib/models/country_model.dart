class Country {
  final String name;
  final String code;
  final String flag;

  Country({required this.name, required this.code, required this.flag});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'].toString(),
      code: json['idd']['root'].toString(),
      flag: json['flags']['svg'].toString(),
    );
  }
}
