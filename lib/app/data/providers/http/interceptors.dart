import 'package:cuidame/app/data/providers/dependences_injector.dart';
import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';

class CaregiverInterceptor extends InterceptorContract {
  late UserLoginService _userLoginService;
  final type = 'caregiver';

  CaregiverInterceptor() {
    _userLoginService = DependencesInjector.get<UserLoginService>();
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (kDebugMode) {
      UtilsLogger().i('HTTP CALL: ${request.url}');
    }

    final userToken = await _userLoginService.userToken;
    if (userToken != null) {
      request.headers['Authorization'] = userToken;
      request.headers['Type'] = 'caregiver';
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async {
    if (response.statusCode == 401) {
      _userLoginService.signOut();
    }

    if (response.statusCode == 400) {
      throw Exception(response.reasonPhrase);
    }
    return response;
  }
}
