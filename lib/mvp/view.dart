import 'package:flutter_bbs/mvp/presenter.dart';
///created by sgh     2019-3-3
/// MVP中View层的顶层接口
abstract class IMVPView {
  void showToast(content);
  void setPresenter(presenter);
}


abstract class IBaseView extends IMVPView {
  IBasePresenter _presenter;
  IBasePresenter get presenter => _presenter;

  @override
  setPresenter(presenter) {
    _presenter = presenter;
  }
  //获取网络数据的方法
  toGetNetData();

  //获取更多网络数据的方法
  toGetMoreNetData();

  //刷新的方法
  toRefresh();

  bindData(sourcedata, type);
}

abstract class IMainView extends IMVPView{
  getWidget(index);
  getTabBar(index);
}