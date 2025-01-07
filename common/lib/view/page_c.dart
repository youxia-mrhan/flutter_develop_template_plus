import 'package:app/app.dart';
import 'package:common/mvvm/base_page.dart';
import 'package:common/mvvm/base_view_model.dart';
import 'package:common/res/string/str_common.dart';
import 'package:common/router/common_page_tag.dart';
import 'package:common/router/navigator_util.dart';
import 'package:flutter/material.dart';

class PageCView extends BaseStatefulPage {
  PageCView({super.key});

  @override
  PageCViewState createState() => PageCViewState();
}

class PageCViewState extends BaseStatefulPageState<PageCView,PageCViewModel> {

  @override
  void initAttribute() {

  }

  @override
  void initObserver() {

  }

  @override
  PageCViewModel viewBindingViewModel() {
    /// ViewModel 和 View 相互持有
    return PageCViewModel()..viewState = this;
  }

  @override
  Widget appBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StrCommon.pageC),
      ),
      body: SizedBox(
        width: media!.size.width,
        height: media!.size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                NavigatorUtil.push(context,CommonPageTag.pageD,replace:true);
              },
              child: Text(StrCommon.toPageD),
            ),
          ],
        ),
      ),
    );
  }

}

class PageCViewModel extends PageViewModel<PageCViewState> {

  @override
  onCreate() {

  }

  @override
  Future<PageViewModel?> requestData({Map<String, dynamic>? params}) {
    return Future.value(null);
  }

}
