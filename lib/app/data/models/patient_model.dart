// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PatientModel {
  String? name;
  DateTime? birthDate;
  String? avatar;
  int? sex;

  PatientModel({
    this.name,
    this.birthDate,
    this.avatar,
    this.sex,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'birth_date': birthDate?.toUtc().toIso8601String(),
      'avatar': avatar,
      'sex': sex,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      name: map['name'] != null ? map['name'] as String : null,
      birthDate: map['birth_date'] != null ? DateTime.tryParse(map['birth_date'] as String) : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      sex: map['sex'] != null ? map['sex'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) => PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
