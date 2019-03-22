
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/pages/board/board.dart';
import 'package:flutter_bbs/pages/home/home.dart';
import 'package:flutter_bbs/pages/message/message.dart';
import 'package:flutter_bbs/mvp/view.dart';

import 'package:flutter/material.dart';

///created by sgh     2019-3-3
/// Main界面中View的实现类
class MainViewImpl extends IMainView {
  IMainPresenter mainPresenterImpl;
  TickerProvider _provider;
  TabController _controller1;       //负责第一个界面
  TabController _controller2;        // 负责第三个界面

  MainViewImpl(TickerProvider previder) {
    this._provider = previder;
    _controller1 = TabController(length: 3, vsync: _provider);
    _controller2 = TabController(length: 4, vsync: _provider);
  }

  @override
  getWidget(index) {
    var widget;
    switch(index) {
      case 0:
        widget = HomePageWidget(controller: _controller1,);
        break;
      case 1:
        widget = BoardWidget();
        break;
      case 2:
        widget = MessagePageWidget(controller: _controller2,);
        break;
    }
    return widget;
  }

  @override
  void showToast(content) {
  }

  @override
  getTabBar(index) {
    var widget;
    switch(index) {
      case 0:
        widget = _buildHmoeTabBar();
        break;
      case 1:
        widget = PreferredSize(preferredSize: Size.fromHeight(0), child: Container(width: 0, height: 0,),);
        break;
      case 2:
        widget = _buildMessageTabBar();
    }
    return widget;
  }

  var homeTabTitles = <String>['今日热门','最新回复', '最新发表']; ////Home界面中的Tab导航的标题
  //构建Home的TabBar
  Widget _buildHmoeTabBar() {
    return TabBar(
      controller: _controller1,
      labelPadding: EdgeInsets.all(8),
      tabs: <Widget>[
        Text(homeTabTitles[0], style: TextStyle(fontSize: 15)),
        Text(homeTabTitles[1], style: TextStyle(fontSize: 15)),
        Text(homeTabTitles[2], style: TextStyle(fontSize: 15))
      ],
    );
  }

  var messageTabTitles = ['帖子回复', '@我', '私信', '系统消息']; //Message界面中的Tab导航的标题
  //构建Message的TabBar
  Widget _buildMessageTabBar() {
    return TabBar(
      controller: _controller2,
      labelPadding: EdgeInsets.all(8),
      tabs: <Widget>[
        Text(messageTabTitles[0], style: TextStyle(fontSize: 15)),
        Text(messageTabTitles[1], style: TextStyle(fontSize: 15)),
        Text(messageTabTitles[2], style: TextStyle(fontSize: 15)),
        Text(messageTabTitles[3], style: TextStyle(fontSize: 15))
      ],
    );
  }

  @override
  void setPresenter(presenter) {
    this.mainPresenterImpl = presenter;
  }

}