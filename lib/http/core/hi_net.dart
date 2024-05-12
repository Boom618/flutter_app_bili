import 'package:flutter_bili_app/http/core/hi_error.dart';
import 'package:flutter_bili_app/http/core/hi_net_adapter.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

import 'dio_adapter.dart';

/// 单例类
class HiNet {
  HiNet._();

  static HiNet _instance = HiNet._();

  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e);
    } catch (e) {
      // 其他异常
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(result);

    // 解析状态码
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        return NeedLogin();
      case 403:
        return NeedAuth(result.toString(), data: result);
      default:
        return HiNetError(status ?? 400, result.toString(), data: result);
    }
  }

  Future<dynamic> send(BaseRequest request) async {
    // printLog('url:${request.url()}');
    // printLog('method:${request.httpMethod()}');
    // request.addHeader("token", "123");
    // printLog('header:${request.header}');
    // return Future.value({
    //   "statusCode": 200,
    //   "data": {"code": 0, "message": 'success '}
    // });
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print("Hi_log:${log.toString()}");
  }
}
