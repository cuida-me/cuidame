import 'package:cuidame/app/data/providers/http/interceptors.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

final Client httpClientCaregiver = InterceptedClient.build(
  interceptors: [
    CaregiverInterceptor(),
  ],
);

final httpClientPatient = InterceptedClient.build(
  interceptors: [
    PatientInterceptor(),
  ],
);
