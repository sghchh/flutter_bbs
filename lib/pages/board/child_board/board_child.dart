import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/board.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/board/child_board/board_child_stateful.dart';
import 'package:flutter_bbs/pages/board/model.dart';
import 'package:flutter_bbs/pages/board/presenter.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;
import 'package:flutter_bbs/utils/constant.dart' as const_util;

/// 展示子板块内容的界面
class ChildBoardInfoWidget extends StatefulWidget {
  int fid; //获取子板块内容必须传递的参数
  String boardName; //
  BoardPresenterImpl _presenter;
  BoardModelImpl _model;
  ChildBoardInfoViewImpl _view;

  ChildBoardInfoWidget(fid, name)
      : _presenter = BoardPresenterImpl(),
        _model = BoardModelImpl() {
    this.fid = fid;
    this.boardName = name;
  }

  @override
  State<StatefulWidget> createState() {
    _view = ChildBoardInfoViewImpl(this.fid);
    _presenter.bindView(_view);
    _presenter.bindModel(_model);
    _view.setPresenter(_presenter);
    return _view;
  }
}

class ChildBoardInfoViewImpl extends State<ChildBoardInfoWidget> with SingleTickerProviderStateMixin
    implements IBaseView {
  BoardPresenterImpl _presenter;
  Board sourceData;
  int fid;

  ChildBoardInfoViewImpl(this.fid);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: toGetNetData(),
      builder: (context, snaphot) {
        if (!snaphot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (snaphot.data.runtimeType == String)
          return Center(
            child: Text('error'),
          );

        print("这是futurebuilder");
        // 成功获取数据
        if (snaphot.data.list.length == 0) {
         return MaterialApp(
              title: "清水河畔",
              home: Scaffold(
                  body: Center(child: Text('该板块已经关闭...'),)));
        }
        sourceData = snaphot.data.list[0];
        return MaterialApp(
            title: "清水河畔",
            home: DefaultTabController(length: sourceData.board_list.length,
                child: Scaffold(
                    appBar: sourceData == null
                        ? null
                        : AppBar(
                      title: Text(sourceData.board_category_name),
                      centerTitle: true,
                      bottom: sourceData == null
                          ? null
                          : _buildTabBar(sourceData.board_list),
                    ),
                    body: TabBarView(children: _buildBody()))));
      },
    );
  }

  @override
  bindData(sourcedata, type) {
    return null;
  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get presenter => _presenter;

  @override
  void setPresenter(presenter) {
    this._presenter = presenter;
  }

  @override
  void showToast(content) {}

  @override
  toGetMoreNetData() {
    return null;
  }

  @override
  toGetNetData() async {
    User finalUser = await user_cache.finalUser();
    return presenter.loadNetData(query: {
      'accessToken': finalUser.token,
      'accessSecret': finalUser.secret,
      'apphash': await user_cache.getAppHash(),
      'sdkVersion': const_util.sdkVersion,
      'fid': fid
    }, type: const_util.board_childBoard);
  }

  @override
  toRefresh() {
    return null;
  }

  // 根据data构建tab
  Widget _buildTabBar(List<ChildBoard> data) {
    var tabs = <Widget>[];
    for (int i = 0; i < data.length; i++) {
      var tab = Text(data[i].board_name, style: TextStyle(fontSize: 15));
      tabs.add(tab);
    }
    return TabBar(labelPadding: EdgeInsets.all(8), tabs: tabs, isScrollable: true,);
  }

  // 构建Scallod的body
  List<Widget> _buildBody() {
    var result = <Widget>[];
    for (int i = 0; i < sourceData.board_list.length; i++) {
      var item = BoardPostWidget(sourceData.board_list[i].board_name, sourceData.board_list[i].board_id);
      result.add(item);
    }
    return result;
  }
}
