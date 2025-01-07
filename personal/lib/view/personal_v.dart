import 'dart:math';

import 'package:app/app.dart';
import 'package:common/mvvm/base_page.dart';
import 'package:common/res/img/common_img_path.dart';
import 'package:common/res/style/color_styles.dart';
import 'package:common/res/style/text_styles.dart';
import 'package:common/util/global.dart';
import 'package:common/widget/global_notification_widget.dart';
import 'package:common/widget/notifier_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal/model/user_info_m.dart';
import 'package:personal/res/string/str_personal.dart';
import 'package:personal/view_model/personal_vm.dart';

class PersonalView extends BaseStatefulPage {
  PersonalView({super.key});

  @override
  PersonalViewState createState() => PersonalViewState();
}

class PersonalViewState extends BaseStatefulPageState<PersonalView, PersonalViewModel> {
  @override
  void initAttribute() {}

  @override
  void initObserver() {}

  @override
  viewBindingViewModel() {
    /// ViewModel 和 View 相互持有
    return PersonalViewModel()..viewState = this;
  }

  bool executeSwitchLogin = false;

  @override
  void didChangeDependencies() {
    var operate = GlobalOperateProvider.getGlobalOperate(context: context);

    assert((){
      debugPrint('OrderView.didChangeDependencies --- $operate');
      return true;
    }());

    if (operate == GlobalOperate.switchLogin) {
      executeSwitchLogin = true;
      // 重新请求数据
      // viewModel.requestData();
    }
  }

  @override
  Widget appBuild(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayBlackStyle,
      child: Material(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: media!.padding.top),
                alignment: Alignment.center,
                child: Image.asset(CommonImgPath.ts,package: PACKAGE_COMMON_NAME),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: kToolbarHeight + media!.padding.top),
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text(StrPersonal.register),
                  onPressed: () {
                    // 如果你想刷新的时候，显示loading，加上这两行
                    viewModel?.pageDataModel?.type = NotifierResultType.loading;
                    viewModel?.pageDataModel?.refreshState();

                    var str1 = Random().nextInt(9);
                    var str2 = Random().nextInt(9);
                    var str3 = Random().nextInt(9);
                    var str4 = Random().nextInt(9);
                    var str5 = Random().nextInt(9);
                    viewModel?.registerUser(params: {
                      'username': '${str1}${str2}${str3}${str4}${str5}',
                      'password': '123456',
                      'repassword': '123456'
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: kToolbarHeight + media!.padding.top + 100),
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text(StrPersonal.login),
                  onPressed: () {
                    // 如果你想刷新的时候，显示loading，加上这两行
                    viewModel?.pageDataModel?.type = NotifierResultType.loading;
                    viewModel?.pageDataModel?.refreshState();

                    viewModel?.loginUser(params: {
                      'username': 'aaaaaa',
                      'password': '123456',
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: kToolbarHeight + media!.padding.top + 200),
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: Text(StrPersonal.switchUser),
                  onPressed: () {
                    // 更新本地存储的用户ID，（常用的本地存储库：shared_preferences）
                    // ... ...

                    // 通知所有继承 BaseStatefulPageState 的子页面
                    GlobalOperateProvider.runGlobalOperate(context: context, operate: GlobalOperate.switchLogin);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kToolbarHeight + media!.padding.top),
              color: ColorStyles.color_388E3C,
              child: executeSwitchLogin
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StrPersonal.switchUser),
                  IconButton(
                      onPressed: () {
                        executeSwitchLogin = false;
                        setState(() {});
                      },
                      icon: Icon(Icons.close))
                ],
              )
                  : SizedBox(),
            ),
            _myAppBar(),
          ],
        ),
      ),
    );
  }

  _myAppBar() {
    return Container(
      width: media!.size.width,
      height: kToolbarHeight + media!.padding.top,
      padding: EdgeInsets.only(top: media!.padding.top,left: 16),
      color: AppBarTheme.of(context).backgroundColor,
      alignment: Alignment.centerLeft,
      child: Builder(
        builder: (context) {
          /// 初始化状态设置为 不检查，不然会 返回 loading 组件
          viewModel?.pageDataModel?.type = NotifierResultType.notCheck;
          return NotifierPageWidget<PageDataModel>(
              model: viewModel?.pageDataModel,
              builder: (context, dataModel) {
              final data = dataModel.data as UserInfoModel?;
              String title = (data?.isLogin ?? false) ? '${StrPersonal.loginSuccess}：${data?.username} ${StrPersonal.welcome}' : '${StrPersonal.registerSuccess}：${data?.username} ${StrPersonal.welcome}';
              return Text(
                (data?.username?.isEmpty ?? true) ? StrPersonal.personal : title,
                style: TextStyles.style_222222_20,
              );
            }
          );
        }
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
