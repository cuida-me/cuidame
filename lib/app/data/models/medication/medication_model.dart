// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cuidame/app/data/models/scheduling/schedule_selected_model.dart';

class MedicationModel {
  String? name;
  String? type;
  String? avatar;
  int? quantity;
  List<String>? times;
  List<ScheduleSelectedModel>? schedules;

  MedicationModel({
    this.name,
    this.type,
    this.avatar,
    this.quantity,
    this.times,
    this.schedules,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'avatar': avatar,
      'quantity': quantity,
      'times': times,
      'schedules': schedules?.map((x) => x.toMap()).toList(),
    };
  }

  factory MedicationModel.fromMap(Map<String, dynamic> map) {
    return MedicationModel(
      name: map['name'] != null ? map['name'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      times: map['times'] != null ? List<String>.from(map['times'] as List<dynamic>) : null,
      schedules: map['schedules'] != null
          ? List<ScheduleSelectedModel>.from(
              (map['schedules'] as List<dynamic>).map<ScheduleSelectedModel?>(
                (x) => ScheduleSelectedModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicationModel.fromJson(String source) =>
      MedicationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
