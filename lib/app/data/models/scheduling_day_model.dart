import 'dart:convert';

import 'package:cuidame/app/data/models/scheduling_medication_type.dart';
import 'package:cuidame/app/utils/utils_datetime.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SchedulingDayModel {
  int day;
  String dayName;
  String monthName;
  DateTime? date;
  int dayWeek;
  List<SchedulingModel> schedulings;

  SchedulingDayModel({
    required this.day,
    required this.dayName,
    required this.monthName,
    required this.date,
    required this.dayWeek,
    required this.schedulings,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'day_name': dayName,
      'month_name': monthName,
      'date': date?.toIso8601String(),
      'day_week': dayWeek,
      'schedulings': schedulings.map((x) => x.toMap()).toList(),
    };
  }

  factory SchedulingDayModel.fromMap(Map<String, dynamic> map) {
    return SchedulingDayModel(
      day: map['day'] as int,
      dayName: map['day_name'] as String,
      monthName: map['month_name'] as String,
      date: UtilsDateTime.formatBrParse(map['date']),
      dayWeek: map['day_week'] as int,
      schedulings: List<SchedulingModel>.from(
        (map['schedulings'] as List<dynamic>).map<SchedulingModel>(
          (x) => SchedulingModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SchedulingDayModel.fromJson(String source) =>
      SchedulingDayModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SchedulingModel {
  String id;
  String name;
  DateTime? medicationTime;
  DateTime? medicationTakenTime;
  String dosage;
  int quantity;
  String status;
  String image;
  SchedulingMedicationType type;

  SchedulingModel({
    required this.id,
    required this.name,
    required this.medicationTime,
    required this.medicationTakenTime,
    required this.dosage,
    required this.quantity,
    required this.status,
    required this.image,
    this.type = SchedulingMedicationType.inTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'medication_time': medicationTime?.toIso8601String(),
      'medication_taken_time': medicationTakenTime?.toIso8601String(),
      'dosage': dosage,
      'quantity': quantity,
      'status': status,
      'image': image,
    };
  }

  factory SchedulingModel.fromMap(Map<String, dynamic> map) {
    return SchedulingModel(
      id: map['id'] as String,
      name: map['name'] as String,
      medicationTime: UtilsDateTime.formatBrParse(map['medication_time']),
      medicationTakenTime: UtilsDateTime.formatBrParse(map['medication_taken_time']),
      dosage: map['dosage'] as String,
      quantity: map['quantity'] as int,
      status: map['status'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchedulingModel.fromJson(String source) =>
      SchedulingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
