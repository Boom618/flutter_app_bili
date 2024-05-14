import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/http/request/notice_request.dart';
import 'package:flutter_bili_app/mode/video_model.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';

import 'http/core/hi_error.dart';
import 'http/core/hi_net.dart';
import 'page/home_page.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({super.key});

  @override
  State<BiliApp> createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  final BiliRouteInformationParser _biliRouteInformationParser = BiliRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    // 定义路由
    var widget = Router(
      routerDelegate: _routeDelegate,
      routeInformationParser: _biliRouteInformationParser,
      routeInformationProvider: PlatformRouteInformationProvider(
          initialRouteInformation: RouteInformation(location: '/')),
    );

    return MaterialApp(
      home: widget,
    );
  }
}


class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  BiliRouteDelegate() :navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> pages = [];

  VideoModel? videoModel;

  BiliRoutePath? page;

  @override
  Widget build(BuildContext context) {
    pages = [
      pageWarp(HomePage(
        onJumpToDetail: (videoModel) {
          this.videoModel = videoModel;
          notifyListeners();
        },
      )),
      if(videoModel != null) pageWarp(VideoDetailPage(videoModel!))
    ];
    // 返回路由堆栈信息
    return Navigator(
        key: navigatorKey,
        pages: pages;
        onPopPage: (route, result)
    {
      // 这里控制是否可以返回
      if (!route.didPop(result)) {
        return false;
      }
      return true;
    });
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath page) async {
    this.page = page;
  }

}

///可缺省，主要应用与web，持有RouteInformationprovider 提供的 RouteInformation
class BiliRouteInformationParser extends RouteInformationParser<BiliRoutePath> {
  @override
  Future<BiliRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    // 初始化
    final uri = Uri.parse(routeInformation.location!);
    // 返回路由
    if (uri.pathSegments.isEmpty) {
      return BiliRoutePath.home();
    }
    return BiliRoutePath.detail();
  }
}

///定义路由数据，path
class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}

/// 创建 page
pageWarp(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}