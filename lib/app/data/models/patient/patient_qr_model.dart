import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PatientQrModel {
  String? ip;
  String deviceId;

  PatientQrModel({
    this.ip,
    required this.deviceId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ip': ip,
      'device_id': deviceId,
    };
  }

  factory PatientQrModel.fromMap(Map<String, dynamic> map) {
    return PatientQrModel(
      ip: map['ip'] as String,
      deviceId: map['device_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientQrModel.fromJson(String source) => PatientQrModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
