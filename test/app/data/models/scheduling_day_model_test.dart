import 'dart:convert';

import 'package:cuidame/app/data/models/scheduling_day_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('scheduling day model ...', (tester) async {
    String data = await rootBundle.loadString('assets/mock/data.json');
    final dataJson = await json.decode(data) as List;

    final resList = dataJson.map((e) => SchedulingDayModel.fromMap(e)).toList();
    // ignore: avoid_print
    print(resList[0].schedulings[0].medicationTime);

    final f = DateFormat('dd/MM/yyyy hh:mm');

    // ignore: avoid_print
    print(f.parse('01/10/2023 00:00'));
  });
}
