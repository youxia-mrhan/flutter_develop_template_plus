import 'package:common/mvvm/base_view_model.dart';
import 'package:common/paging/paging_data_model.dart';
import 'package:common/widget/notifier_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:message/api/message_repository.dart';
import 'package:message/model/message_list_m.dart';
import 'package:message/view/message_v.dart';

class MessageViewModel extends PageViewModel<MessageViewState> {

  CancelToken? cancelToken;
  PagingDataModel? pagingDataModel;

  @override
  onCreate() {

    assert((){
      /// 拿到 页面状态里的 对象、属性 等等
      debugPrint('---executeSwitchLogin：${state.executeSwitchLogin}');
      return true;
    }());

    cancelToken = CancelToken();
    pageDataModel = PageDataModel();
    pagingDataModel = PagingDataModel();
    requestData();
  }

  @override
  onDispose() {
    if(!(cancelToken?.isCancelled ?? true)) {
      cancelToken?.cancel();
    }

    assert((){
      debugPrint('MessageViewModel.onDispose()');
      return true;
    }());

    /// 别忘了执行父类的 onDispose
    super.onDispose();
  }

  /// 记录是否是第一次请求数据
  bool initRequest = true;

  @override
  Future<PageViewModel?> requestData({Map<String, dynamic>? params}) async {
    PageViewModel viewModel = await MessageRepository().getMessageData(
        pageViewModel: this,
        cancelToken: cancelToken,
        curPage: params?['curPage'] ?? 1,
    );

    /// 第一次请求数据，不会触发 下拉刷新 和 上拉加载更多方法，通过标识，初始化一些Paging参数
    if(initRequest) {
      pagingDataModel?.originalListDataLength = (viewModel.pageDataModel?.data as MessageListModel).datas?.length ?? 0;
    }

    initRequest = false;

    pageDataModel = viewModel.pageDataModel;

    /// 分页代码
    pageDataModel?.bindingPaging(
        viewModel,
        pageDataModel!,
        pagingDataModel!,
        this);

    pageDataModel?.refreshState();

    /// 注意：使用需要返回 PageDataModel对象，它和
    return Future<PageViewModel>.value(viewModel);
  }

}

