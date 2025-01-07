import 'package:app/app.dart';
import 'package:common/view/page_a.dart';
import 'package:common/view/page_a2.dart';
import 'package:common/view/page_b.dart';
import 'package:common/view/page_c.dart';
import 'package:common/view/page_d.dart';
import 'package:common/router/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:order/view/order_v.dart';

class CommonPageTag {

  static String root = '/';

  static String pageA = '/PageAView';

  static String pageA2 = '/PageA2View';

  static String pageB = '/PageBView';

  static String pageC = '/PageCView';

  static String pageD = '/PageDView';

  // 注册路由
  static void initRouter() {

    // 根页面
    Routers.router.define(
      root,
      handler: Handler(
        handlerFunc: (_, __) => AppMainPage(),
      ),
    );

    // 页面A 需要 非对象类型 参数（通过 拼接 传参数）
    Routers.router.define(
      pageA,
      handler: Handler(
        handlerFunc: (_, Map<String, List<String>> params) {

          // 获取路由参数
          String? name = params['name']?.first;
          String? title = params['title']?.first;
          String? url = params['url']?.first;
          String? age = params['age']?.first ?? '-1';
          String? price = params['price']?.first ?? '-1';
          String? flag = params['flag']?.first ?? 'false';

          return PageAView(
              name: name,
              title: title,
              url: url,
              age: int.parse(age),
              price: double.parse(price),
              flag: bool.parse(flag)
          );

        },
      ),
    );

    // 页面A2 需要 非对象类型 参数（通过 arguments 传参数）
    Routers.router.define(
      pageA2,
      handler: Handler(
        handlerFunc: (context, _) {

          // 获取路由参数
          final arguments = context?.settings?.arguments as Map<String, dynamic>;

          String? name = arguments['name'] as String?;
          String? title = arguments['title'] as String?;
          String? url = arguments['url'] as String?;
          int? age = arguments['age'] as int?;
          double? price = arguments['price'] as double?;
          bool? flag = arguments['flag'] as bool?;

          return PageA2View(
              name: name,
              title: title,
              url: url,
              age: age,
              price: price,
              flag: flag ?? false
          );

        },
      ),
    );

    // 页面B 需要 对象类型 参数
    Routers.router.define(
      pageB,
      handler: Handler(
        handlerFunc: (context, Map<String, List<String>> params) {
          // 获取路由参数
          TestParamsModel? paramsModel = context?.settings?.arguments as TestParamsModel?;
          return PageBView(paramsModel: paramsModel);
        },
      ),
    );

    // 页面C 无参数
    Routers.router.define(
      pageC,
      handler: Handler(
        handlerFunc: (_, __) => PageCView(),
      ),
    );

    // 页面D 无参数
    Routers.router.define(
      pageD,
      handler: Handler(
        handlerFunc: (_, __) => PageDView(),
      ),
    );
  }

}
