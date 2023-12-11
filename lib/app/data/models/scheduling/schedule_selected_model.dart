import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ScheduleSelectedModel {
  int? dailyOfWeek;
  bool? enabled;

  ScheduleSelectedModel({
    this.dailyOfWeek,
    this.enabled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'daily_of_week': dailyOfWeek,
      'enabled': enabled,
    };
  }

  factory ScheduleSelectedModel.fromMap(Map<String, dynamic> map) {
    return ScheduleSelectedModel(
      dailyOfWeek: map['daily_of_week'] != null ? map['daily_of_week'] as int : null,
      enabled: map['enabled'] != null ? map['enabled'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleSelectedModel.fromJson(String source) =>
      ScheduleSelectedModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
