import 'package:flutter_bili_app/http/core/hi_net_adapter.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

///测试适配器，mock数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<String>> send<String>(BaseRequest request) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return HiNetResponse<String>();
  }
}

