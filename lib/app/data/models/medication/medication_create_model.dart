import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MedicationCreateModel {
  String? name;
  int? typeId;
  String? avatar;
  int? quantity;
  List<String>? times;
  List<MedicationCreateDailySelectedModel>? schedules;

  MedicationCreateModel({
    this.name,
    this.typeId,
    this.avatar,
    this.quantity,
    this.times,
    this.schedules,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type_id': typeId,
      'avatar': avatar,
      'quantity': quantity,
      'times': times,
      'schedules': schedules?.map((x) => x.toMap()).toList(),
    };
  }

  factory MedicationCreateModel.fromMap(Map<String, dynamic> map) {
    return MedicationCreateModel(
      name: map['name'] != null ? map['name'] as String : null,
      typeId: map['type_id'] != null ? map['type_id'] as int : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      times: map['times'] != null ? List<String>.from(map['times'] as List<String>) : null,
      schedules: map['schedules'] != null
          ? List<MedicationCreateDailySelectedModel>.from(
              (map['schedules'] as List<int>).map<MedicationCreateDailySelectedModel?>(
                (x) => MedicationCreateDailySelectedModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicationCreateModel.fromJson(String source) =>
      MedicationCreateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MedicationCreateDailySelectedModel {
  int? dailyOfWeek;
  bool? enabled;

  MedicationCreateDailySelectedModel({
    this.dailyOfWeek,
    this.enabled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'daily_of_week': dailyOfWeek,
      'enabled': enabled,
    };
  }

  factory MedicationCreateDailySelectedModel.fromMap(Map<String, dynamic> map) {
    return MedicationCreateDailySelectedModel(
      dailyOfWeek: map['daily_of_week'] != null ? map['daily_of_week'] as int : null,
      enabled: map['enabled'] != null ? map['enabled'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicationCreateDailySelectedModel.fromJson(String source) =>
      MedicationCreateDailySelectedModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
