import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/services/caregiver_login_service.dart';
import 'package:cuidame/app/data/services/patient_login_service.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';

class CaregiverInterceptor extends InterceptorContract {
  late CaregiverLoginService _caregiverLoginService;
  final type = 'caregiver';

  CaregiverInterceptor() {
    _caregiverLoginService = DependencesInjector.get<CaregiverLoginService>();
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (kDebugMode) {
      UtilsLogger().i('HTTP CALL: ${request.url}');
    }

    final userToken = await _caregiverLoginService.userToken;
    if (userToken != null) {
      request.headers['Authorization'] = userToken;
      request.headers['Type'] = 'caregiver';
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async {
    if (response.statusCode == 401) {
      _caregiverLoginService.signOut();
    }

    if (response.statusCode == 400 || response.statusCode >= 500) {
      UtilsLogger().e(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }

    return response;
  }
}

class PatientInterceptor extends InterceptorContract {
  late PatientLoginService _patientLoginService;
  final type = 'caregiver';

  PatientInterceptor() {
    _patientLoginService = DependencesInjector.get<PatientLoginService>();
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (kDebugMode) {
      UtilsLogger().i('HTTP CALL: ${request.url}');
    }

    final userToken = await _patientLoginService.userToken;
    if (userToken != null) {
      request.headers['Authorization'] = userToken;
      request.headers['Type'] = 'patient';
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async {
    if (response.statusCode == 401) {
      _patientLoginService.signOut();
    }

    if (response.statusCode == 400 || response.statusCode >= 500) {
      UtilsLogger().e(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }

    return response;
  }
}
