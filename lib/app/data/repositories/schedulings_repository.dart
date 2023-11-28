import 'dart:convert';

import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:cuidame/app/data/providers/http/http_client.dart';
import 'package:flutter/services.dart';

abstract class SchedulesRepository {
  Future<List<SchedulingDayModel>?> retrieveSchedules();
}

class SchedulesRepositoryImpl implements SchedulesRepository {
  // ignore: unused_field
  final HttpClient _client;

  SchedulesRepositoryImpl(this._client);

  @override
  Future<List<SchedulingDayModel>?> retrieveSchedules() async {
    // final res = _client.get('');

    String data = await rootBundle.loadString('assets/mock/data.json');
    final dataJson = await json.decode(data) as List;

    final resList = dataJson.map((e) => SchedulingDayModel.fromMap(e)).toList();
    return resList;
  }
}
