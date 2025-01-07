import 'package:app/application.dart';

/// 预发布环境 入口函数
void main() => Application.runApplication(
      envTag: EnvTag.pre, // 预发布环境
      platform: ApplicationPlatform.app, // 手机应用
      isGlobalNotification: true, // 是否有全局通知操作，比如切换用户
      baseUrl: 'https://www.wanandroid.com/', // 域名
    );
