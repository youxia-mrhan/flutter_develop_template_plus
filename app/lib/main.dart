import 'package:app/application.dart';

/// 生产环境 入口函数
void main() => Application.runApplication(
  envTag: EnvTag.prod, // 生产环境
  platform: ApplicationPlatform.app, // 手机应用
  isGlobalNotification: true, // 是否有全局通知操作，比如切换用户
  baseUrl: 'https://www.wanandroid.com/', // 域名
);
