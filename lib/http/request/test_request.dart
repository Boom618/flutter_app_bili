import 'package:flutter_bili_app/http/request/base_request.dart';

/// 测试接口类
class TestRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() => false;

  @override
  String path() {
    return 'uapi/test/test';
  }
}
