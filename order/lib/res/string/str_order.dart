/// 这里统一写全局，非动态、固定的 字符串文本
/// 如果哪一天 项目突然要求 使用 国际化
/// 直接将这里的内容，拷贝到 国际化插件生成的 映射文件中，再 对照中文 翻译成 指定语言
///
/// 订单
class StrOrder {

  static const String order = 'Order';
  static const String noObjectToPageA = '携带 非对象类型 前往PageA（拼接方式）';
  static const String noObjectToPageA2 = '携带 非对象类型 前往PageA2（arguments方式）';
  static const String objectToPageB = '携带 对象类型 前往PageB';

}