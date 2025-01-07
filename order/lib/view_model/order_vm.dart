import 'package:common/mvvm/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:order/view/order_v.dart';

class OrderViewModel extends PageViewModel<OrderViewState> {

  @override
  onCreate() {

    assert((){
      /// 拿到 页面状态里的 对象、属性 等等
      debugPrint('state: --- ${state.paramsModel}');
      return true;
    }());

  }

  @override
  Future<PageViewModel?> requestData({Map<String, dynamic>? params}) {
      return Future.value(null);
  }
}