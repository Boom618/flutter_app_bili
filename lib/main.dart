import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/mode/video_model.dart';
import 'package:flutter_bili_app/naviaator/hi_navigator.dart';
import 'package:flutter_bili_app/page/video_detail_page.dart';
import 'package:flutter_bili_app/util/color.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';

import 'page/home_page.dart';
import 'page/login_page.dart';
import 'page/registration_page.dart';

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

  @override
  Widget build(BuildContext context) {
    // FutureBuilder 处理程序预加载
    return FutureBuilder<HiCache>(
      future: HiCache.preInit(), // 初始化
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        // 定义路由
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: _routeDelegate)
            : const Scaffold(body: Center(child: CircularProgressIndicator()));

        return MaterialApp(
          home: widget,
          theme: ThemeData(primarySwatch: white),
        );
      },
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];

  VideoModel? videoModel;

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    // 返回页面在堆栈中，不等于 -1
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      // page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel!));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage(onJumpToLogin: (){
        _routeStatus = RouteStatus.login;
        notifyListeners();
      },));
    } else if (routeStatus == RouteStatus.notice) {
      // page = pageWrap(NoticePage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }
    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    //通知路由发生变化
    HiNavigator.getInstance().notify(tempPages, pages);

    // 返回路由堆栈信息
    return Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          // 这里控制是否可以返回
          if (!route.didPop(result)) {
            return false;
          }
          return true;
        });
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath page) async {
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
