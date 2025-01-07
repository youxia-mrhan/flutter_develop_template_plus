import 'package:common/router/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:personal/view/personal_test_v.dart';

class PersonalPageTag {

  static String personalTestV = '/PersonalTestV';

  // 注册路由
  static void initRouter() {
    Routers.router.define(
      personalTestV,
      handler: Handler(
        handlerFunc: (_, __) => PersonalTestV(),
      ),
    );
  }

}
