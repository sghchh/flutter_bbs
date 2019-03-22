import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';

import 'package:meta/meta.dart';

///created by sgh     2019-3-3
/// MainPage对应的Presenter的实现类
class MainPresenterImpl extends IMainPresenter {

  IMainModel mainModelImpl;
  IMainView mainViewImpl;

  MainPresenterImpl({@required IMainView mView, @required IMainModel mModel}) {
    bindModel(mModel);
    bindView(mView);
    _onBind();
  }

  void _onBind() {
    mainViewImpl.setPresenter(this);
    mainModelImpl.setPresenter(this);

  }

  @override
  getWidgetByIndex(index) {
    return mainViewImpl.getWidget(index);
  }


  @override
  getTabBarByIndex(index) {
    return mainViewImpl.getTabBar(index);
  }

  @override
  bindModel(model) {
    this.mainModelImpl = model;
  }

  @override
  bindView(view) {
    this.mainViewImpl = view;
  }

}