import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:meta/meta.dart';

/**
 * created by sgh     2019-3-3
 * MVP中Presenter的顶层接口
 */
abstract class IMVPPresenter {

  bindView(view);
  bindModel(model);

}

abstract class IBasePresenter<T extends IBaseView, E extends IBaseModel> extends IMVPPresenter {
  E _mModel;
  T _mView;

  E get mModel => _mModel;
  T get mView => _mView;
  @override
  bindModel(model) {
    this._mModel = model;
  }

  @override
  bindView(view) {
    this._mView = view;
  }


  Future loadNetData({String type, @required Map<String, dynamic> query});
  loadMoreNetData({String type, @required Map<String, dynamic> query});
  refresh({String type, @required Map<String, dynamic> query});
}

abstract class IMainPresenter extends IMVPPresenter {
  getWidgetByIndex(index);
  getTabBarByIndex(index);
}