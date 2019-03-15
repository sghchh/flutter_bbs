import 'package:flutter_bbs/mvp/presenter.dart';
///created by sgh     2019-3-3
/// MVP中Model层的顶层接口
abstract class IMVPModel {
  void setPresenter(presenter);
}

abstract class IBaseModel extends IMVPModel {

  IBasePresenter _presenter;
  IBasePresenter get presenter => _presenter;

  @override
  void setPresenter(presenter) {
    this._presenter = presenter;
  }

  //首次加载网络数据的方法
  Future onLoadNetData({String type, Map<String, dynamic> query});

  //加载更多网络数据的方法
  Future onLoadMoreData({String type, Map<String, dynamic> query});

  //刷新的方法
  Future onRefresh({String type, Map<String, dynamic> query});
}

abstract class IMainModel extends IMVPModel {

}