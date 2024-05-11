import '../dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  // 传入参数
  var pathParams;
  var useHttps = true;

  // 域名
  String authority() => "api.devio.org";

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接 path 参数
    if (pathParams != null) {
      if (path().endsWith('/')) {
        pathStr = "${path()}${pathParams.toString()}";
      } else {
        pathStr = "${path()}/${pathParams.toString()}";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    if (needLogin()) {
      //给需要登录的接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass());
    }
    print("uri = $uri");
    return uri.toString();
  }
  // 是否需要登录
  bool needLogin();

  Map<String,String> params = Map();

  // 添加参数
  BaseRequest add(String key, Object value) {
    params[key] = value.toString();
    return this;
  }
  Map<String, dynamic> header = {
    'course-flag': 'fa',
    //访问令牌
    "auth-token": "MjAyMC0wNi0yMyAwMzoyNTowMQ==fa",
  };
  // 添加 heade
  BaseRequest addHeader(String key, Object value) {
    // todo params
    // params[key] = value.toString();
    header[key] = value.toString();
    return this;
  }

}
