import 'dart:math';

import 'package:common/mvvm/base_page.dart';
import 'package:common/res/string/str_common.dart';
import 'package:message/res/string/str_message.dart';
import 'package:common/res/style/color_styles.dart';
import 'package:common/res/style/text_styles.dart';
import 'package:common/widget/global_notification_widget.dart';
import 'package:common/widget/notifier_widget.dart';
import 'package:common/widget/refresh_load_widget.dart';
import 'package:flutter/material.dart';
import 'package:message/model/message_list_m.dart';
import 'package:message/view_model/message_vm.dart';

class MessageView extends BaseStatefulPage {
  MessageView({super.key});

  @override
  MessageViewState createState() => MessageViewState();
}

class MessageViewState extends BaseStatefulPageState<MessageView, MessageViewModel> {

  @override
  MessageViewModel viewBindingViewModel() {
    /// ViewModel 和 View 相互持有
    return MessageViewModel()..viewState = this;
  }

  @override
  void initAttribute() {

  }

  @override
  void initObserver() {}

  @override
  void dispose() {
    assert((){
      debugPrint('MessageView.onDispose()');
      return true;
    }());
    super.dispose();
  }

  bool executeSwitchLogin = false;

  @override
  void didChangeDependencies() {
    var operate = GlobalOperateProvider.getGlobalOperate(context: context);

    assert((){
      debugPrint('MessageView.didChangeDependencies --- $operate');
      return true;
    }());

    // 切换用户
    // 正常业务流程是：从本地存储，拿到当前最新的用户ID，请求接口，我这里偷了个懒 😄
    // 直接使用随机数，模拟 不同用户ID
    if (operate == GlobalOperate.switchLogin) {
      executeSwitchLogin = true;

      // 重新请求数据
      // 如果你想刷新的时候，显示loading，加上这两行
      viewModel?.pageDataModel?.type = NotifierResultType.loading;
      viewModel?.pageDataModel?.refreshState();

      viewModel?.pagingDataModel?.listData.clear();
      viewModel?.requestData(params: {'curPage': Random().nextInt(20)});
    }
  }

  @override
  Widget appBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppBarTheme.of(context).backgroundColor,
          title: Text(
            StrMessage.message,
            style: TextStyles.style_222222_20,
          )),
      body: NotifierPageWidget<PageDataModel>(
        model: viewModel?.pageDataModel,
        builder: (context, dataModel) {
          final dataList = dataModel.pagingDataModel?.listData;
          return Stack(
            children: [
              RefreshLoadWidget(
                pagingDataModel: dataModel.pagingDataModel!,
                scrollView: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: dataList?.length ?? 0,
                    itemBuilder: (context, index) {
                      var data = dataList?[index] as Datas;
                      return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 0.5,
                                    color: ColorStyles.color_000000
                                )
                            )
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text('${data.title}'),
                      );
                    }),
              ),
              Container(
                color: ColorStyles.color_388E3C,
                child: executeSwitchLogin ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StrCommon.executeSwitchUser),
                    IconButton(onPressed: (){
                      executeSwitchLogin = false;
                      setState(() {});
                    }, icon: Icon(Icons.close))
                  ],
                ) : SizedBox(),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
