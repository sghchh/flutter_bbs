
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';

class MainModelImpl extends IMainModel {
  IMainPresenter mainPresenterImpl;

  @override
  void setPresenter(presenter) {
    this.mainPresenterImpl = presenter;
  }

}