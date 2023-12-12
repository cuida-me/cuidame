import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PatientFinishLoginModel {
  String? token;
  bool? success;

  PatientFinishLoginModel({
    this.token,
    this.success,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'success': success,
    };
  }

  factory PatientFinishLoginModel.fromMap(Map<String, dynamic> map) {
    return PatientFinishLoginModel(
      token: map['token'] != null ? map['token'] as String : null,
      success: map['success'] != null ? map['success'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientFinishLoginModel.fromJson(String source) =>
      PatientFinishLoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
