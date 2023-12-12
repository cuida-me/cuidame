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
  List<String>? dayColors;
  List<SchedulingModel>? schedulings;

  SchedulingDayModel({
    required this.day,
    required this.dayName,
    required this.monthName,
    required this.date,
    required this.dayWeek,
    required this.dayColors,
    required this.schedulings,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'day_name': dayName,
      'month_name': monthName,
      'date': date?.toIso8601String(),
      'day_week': dayWeek,
      'day_colors': dayColors,
      'schedulings': schedulings?.map((x) => x.toMap()).toList(),
    };
  }

  factory SchedulingDayModel.fromMap(Map<String, dynamic> map) {
    return SchedulingDayModel(
      day: map['day'] as int,
      dayName: map['day_name'] as String,
      monthName: map['month_name'] as String,
      date: map['date'] != null ? UtilsDateTime.formatToLocal(map['date'] as String) : null,
      dayWeek: map['day_week'] as int,
      dayColors: map['day_colors'] != null ? List<String>.from(map['day_colors'] as List<dynamic>) : null,
      schedulings: map['schedulings'] != null
          ? List<SchedulingModel>.from(
              (map['schedulings'] as List<dynamic>).map<SchedulingModel?>(
                (x) => SchedulingModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchedulingDayModel.fromJson(String source) =>
      SchedulingDayModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SchedulingModel {
  int id;
  String name;
  DateTime? medicationTime;
  DateTime? medicationTakenTime;
  String dosage;
  int quantity;
  String status;
  String image;
  String color;
  String medicationType;
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
    required this.color,
    required this.medicationType,
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
      'color': color,
      'medication_type': medicationType,
    };
  }

  factory SchedulingModel.fromMap(Map<String, dynamic> map) {
    return SchedulingModel(
      id: map['id'] as int,
      name: map['name'] as String,
      medicationTime:
          map['medication_time'] != null ? UtilsDateTime.formatToLocal(map['medication_time'] as String) : null,
      medicationTakenTime: map['medication_taken_time'] != null
          ? UtilsDateTime.formatToLocal(map['medication_taken_time'] as String)
          : null,
      dosage: map['dosage'] as String,
      quantity: map['quantity'] as int,
      status: map['status'] as String,
      image: map['image'] as String,
      color: map['color'] as String,
      medicationType: map['medication_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SchedulingModel.fromJson(String source) =>
      SchedulingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
