import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  final UserLoginService _userLoginService;

  late String contentType;
  late http.Client _inner;

  HttpClient(this._userLoginService) {
    _inner = http.Client();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (kDebugMode) {
      UtilsLogger().d('HTTP CALL: ${request.url}');
    }

    final userToken = await _userLoginService.userToken;
    if (userToken != null) {
      request.headers['Authorization'] = userToken;
      request.headers['Type'] = 'caregiver';
    }
    return _inner.send(request);
  }
}
