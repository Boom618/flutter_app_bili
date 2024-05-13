import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/http/request/notice_request.dart';
import 'package:flutter_bili_app/page/login_page.dart';
import 'package:flutter_bili_app/page/registration_page.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';

import 'http/core/hi_error.dart';
import 'http/core/hi_net.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HiCache.preInit();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: RegistrationPage(),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    // 借助 HiNet 发起网络请求
    // TestRequest request = TestRequest();
    // request.add("aa", "ddd").add("bb", "333").add('requestPrams', 'kkk');
    // var result = await HiNet.getInstance().fire(request);
    // print(result);
    setState(() {
      _counter++;
      testNotice();
    });
    // test();
    // testLogin();
  }

  void test() {
    const jsonString =
        "{ \"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";
    //json 转map
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    print('name:${jsonMap['name']}');
    print('url:${jsonMap['url']}');
    //map 转json
    String json = jsonEncode(jsonMap);
    print('json:$json');
  }

  void testLogin() async {
    try {
      // var result =
      //     await LoginDao.registration('userName', '123456', '12455', '1234');
      var result1 = await LoginDao.login('userName', '123456');
      // print(result);
      print(result1);
    } catch (e) {
      print(e);
    }
  }

  void testNotice() async {
    try {
      var notice = await HiNet.getInstance().fire(NoticeRequest());
      print(notice);
    } on NeedLogin catch (e) {
      print(e);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // body: RegistrationPage(),
    );
  }
}
