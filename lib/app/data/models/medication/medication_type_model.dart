import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MedicationTypeModel {
  int? id;
  String? name;
  String? avatar;

  MedicationTypeModel({
    this.id,
    this.name,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'Name': name,
      'Avatar': avatar,
    };
  }

  factory MedicationTypeModel.fromMap(Map<String, dynamic> map) {
    return MedicationTypeModel(
      id: map['ID'] != null ? map['ID'] as int : null,
      name: map['Name'] != null ? map['Name'] as String : null,
      avatar: map['Avatar'] != null ? map['Avatar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicationTypeModel.fromJson(String source) =>
      MedicationTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
