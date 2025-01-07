import 'package:common/router/common_page_tag.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:home/router/home_page_tag.dart';
import 'package:message/router/message_page_tag.dart';
import 'package:order/router/order_page_tag.dart';
import 'package:personal/router/personal_page_tag.dart';

class Routers {
  static FluroRouter router = FluroRouter();

  // 配置路由
  static void configureRouters() {
    router.notFoundHandler = Handler(handlerFunc: (_, __) {
      // 找不到路由时，返回指定提示页面
      return Scaffold(
        body: const Center(
          child: Text('404'),
        ),
      );
    });

    // 初始化路由
    CommonPageTag.initRouter();
    HomePageTag.initRouter();
    MessagePageTag.initRouter();
    OrderPageTag.initRouter();
    PersonalPageTag.initRouter();
  }

}
