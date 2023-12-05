import 'dart:convert';

import 'package:cuidame/app/utils/utils_datetime.dart';

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
      'birth_date': birthDate?.toIso8601String(),
      'avatar': avatar,
      'sex': sex,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      name: map['name'] != null ? map['name'] as String : null,
      birthDate: UtilsDateTime.formatBrParse(map['birth_date']),
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      sex: map['sex'] != null ? map['sex'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) => PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
