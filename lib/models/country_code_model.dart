import 'dart:convert';

class CountryCode {
  String id;
  String countrycode;
  String name;
  String telephonecode;
  CountryCode({
    this.id,
    this.countrycode,
    this.name,
    this.telephonecode,
  });

  factory CountryCode.fromMap(Map<String, dynamic> map) {
    return CountryCode(
      id: map['_id'],
      countrycode: map['country_code'],
      name: map['name'],
      telephonecode: map['telephone_code'],
    );
  }

  factory CountryCode.fromJson(String source) =>
      CountryCode.fromMap(json.decode(source));
}
