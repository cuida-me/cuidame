import 'dart:convert';

import 'package:cuidame/app/utils/utils_datetime.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CaregiverUpdateModel {
  String? name;
  String? avatar;
  DateTime? birthDate;
  int? sex;

  CaregiverUpdateModel({
    this.name,
    this.avatar,
    this.birthDate,
    this.sex,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
      'birth_date': birthDate?.toUtc().toIso8601String(),
      'sex': sex,
    };
  }

  factory CaregiverUpdateModel.fromMap(Map<String, dynamic> map) {
    return CaregiverUpdateModel(
      name: map['name'] != null ? map['name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      birthDate: map['birth_date'] != null ? UtilsDateTime.formatToLocal(map['birth_date']) : null,
      sex: map['sex'] != null ? map['sex'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CaregiverUpdateModel.fromJson(String source) =>
      CaregiverUpdateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
