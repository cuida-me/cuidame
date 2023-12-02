import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PatientModel {
  String? displayName;

  PatientModel({
    this.displayName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      displayName: map['displayName'] != null ? map['displayName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) => PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
