import 'dart:convert';

import 'package:cuidame/app/data/models/patient/patient_model.dart';
import 'package:cuidame/app/utils/utils_datetime.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CaregiverModel {
  int? id;
  String? name;
  DateTime? birthDate;
  String? avatar;
  int? sex;
  String? email;
  String? status;
  PatientModel? patient;

  CaregiverModel({
    this.id,
    this.name,
    this.birthDate,
    this.avatar,
    this.sex,
    this.email,
    this.status,
    this.patient,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'birth_date': birthDate?.toIso8601String(),
      'avatar': avatar,
      'sex': sex,
      'email': email,
      'status': status,
      'patient': patient?.toMap(),
    };
  }

  factory CaregiverModel.fromMap(Map<String, dynamic> map) {
    return CaregiverModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      birthDate: map['birth_date'] != null ? UtilsDateTime.formatToLocal(map['birth_date'] as String) : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      sex: map['sex'] != null ? map['sex'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      patient: map['patient'] != null ? PatientModel.fromMap(map['patient'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CaregiverModel.fromJson(String source) => CaregiverModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
