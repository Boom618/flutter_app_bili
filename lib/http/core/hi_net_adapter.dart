import 'package:flutter_bili_app/http/request/base_request.dart';
import 'dart:convert';

/// 网络请求抽象类
abstract class HiNetAdapter {
  Future<HiNetResponse> send<T>(BaseRequest request);
}


/// 统一返回数据处理
class HiNetResponse {

  dynamic data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;


  HiNetResponse({
    this.data,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }

}
