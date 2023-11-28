import 'package:cuidame/app/data/services/user_login_service.dart';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  final UserLoginService userLoginService;

  late String contentType;
  late http.Client _inner;

  HttpClient(this.userLoginService) {
    _inner = http.Client();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request);
  }
}
