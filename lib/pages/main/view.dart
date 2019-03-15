
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

  @override
  getWidget(index) {
    var widget;
    switch(index) {
      case 0:
        widget = HomePageWidget();
        break;
      case 1:
        widget = BoardWidget();
        break;
      default:
        widget = MessagePageWidget();
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
        widget = null;
        break;
      default:
        widget = _buildMessageTabBar();
    }
    return widget;
  }

  var homeTabTitles = <String>['今日热门','最新回复', '最新发表']; ////Home界面中的Tab导航的标题
  //构建Home的TabBar
  Widget _buildHmoeTabBar() {
    return TabBar(
      labelPadding: EdgeInsets.all(8),
      tabs: <Widget>[
        Text(homeTabTitles[0], style: TextStyle(fontSize: 16)),
        Text(homeTabTitles[1], style: TextStyle(fontSize: 16)),
        Text(homeTabTitles[2], style: TextStyle(fontSize: 16))
      ],
    );
  }

  var messageTabTitles = ['帖子回复', '@我', '私信', '系统消息']; //Message界面中的Tab导航的标题
  //构建Message的TabBar
  Widget _buildMessageTabBar() {
    return TabBar(
      labelPadding: EdgeInsets.all(8),
      tabs: <Widget>[
        Text(messageTabTitles[0], style: TextStyle(fontSize: 16)),
        Text(messageTabTitles[1], style: TextStyle(fontSize: 16)),
        Text(messageTabTitles[2], style: TextStyle(fontSize: 16)),
        Text(messageTabTitles[3], style: TextStyle(fontSize: 16))
      ],
    );
  }

  @override
  void setPresenter(presenter) {
    this.mainPresenterImpl = presenter;
  }

}