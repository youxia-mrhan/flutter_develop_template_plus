import 'package:common/mvvm/base_view_model.dart';
import 'package:common/widget/notifier_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:personal/api/personal_repository.dart';
import 'package:personal/model/user_info_m.dart';
import 'package:personal/view/personal_v.dart';

class PersonalViewModel extends PageViewModel<PersonalViewState> {
  CancelToken? cancelToken;

  @override
  onCreate() {

    assert((){
      /// 拿到 页面状态里的 对象、属性 等等
      debugPrint('---executeSwitchLogin：${state.executeSwitchLogin}');
      return true;
    }());

    cancelToken = CancelToken();
    pageDataModel = PageDataModel();
  }

  @override
  onDispose() {
    if (!(cancelToken?.isCancelled ?? true)) {
      cancelToken?.cancel();
    }
    assert((){
      debugPrint('PersonalViewModel.onDispose()');
      return true;
    }());

    /// 别忘了执行父类的 onDispose
    super.onDispose();
  }

  /// 注册
  Future<PageViewModel?> registerUser({Map<String, dynamic>? params}) async {
    PageViewModel viewModel = await PersonalRepository().registerUser(
        pageViewModel: this,
        cancelToken: cancelToken,
        params: params
    );

    (viewModel.pageDataModel?.data as UserInfoModel?)?.isLogin = false;
    pageDataModel = viewModel.pageDataModel;
    pageDataModel?.refreshState();
    return Future<PageViewModel>.value(viewModel);
  }

  /// 登陆
  Future<PageViewModel?> loginUser({Map<String, dynamic>? params}) async {
    PageViewModel viewModel = await PersonalRepository().loginUser(
        pageViewModel: this,
        cancelToken: cancelToken,
        params: params
    );
    (viewModel.pageDataModel?.data as UserInfoModel?)?.isLogin = true;
    pageDataModel = viewModel.pageDataModel;
    pageDataModel?.refreshState();
    return Future<PageViewModel>.value(viewModel);
  }

  @override
  Future<PageViewModel?> requestData({Map<String, dynamic>? params}) {
    return Future.value(null);
  }

}