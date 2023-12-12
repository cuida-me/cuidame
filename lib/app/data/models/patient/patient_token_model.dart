import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PatientTokenModel {
  String? token;
  
  PatientTokenModel({
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory PatientTokenModel.fromMap(Map<String, dynamic> map) {
    return PatientTokenModel(
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientTokenModel.fromJson(String source) => PatientTokenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
