import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
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
    _view = ChildBoardInfoViewImpl(this.boardName, this.fid);
    _presenter.bindView(_view);
    _presenter.bindModel(_model);
    _view.setPresenter(_presenter);
    return _view;
  }
}

class ChildBoardInfoViewImpl extends State<ChildBoardInfoWidget> with SingleTickerProviderStateMixin
    implements IBaseView {
  BoardPresenterImpl _presenter;
  ChildBoardInfoResponse sourceData;
  Board board;
  List<ChildBoard> childBoard;

  int fid;
  String boardName;

  ChildBoardInfoViewImpl(this.boardName, this.fid);

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

        //有可能该板块不含有子版块
        sourceData = snaphot.data;
        board = sourceData.list.length == 0 ? null : sourceData.list[0];        //不为null则说明该板块含有子板块
        childBoard = board == null ? null : board.board_list;

        return MaterialApp(
            title: "清水河畔",
            home: DefaultTabController(length: board != null ? childBoard.length + 1 : 1,
                child: Scaffold(
                    appBar: sourceData == null
                        ? null
                        : PreferredSize(
                      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.10),
                      child: AppBar(
                        title: Text(boardName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),),
                        centerTitle: true,
                        bottom: sourceData == null
                            ? null
                            : _buildTabBar(),
                      ),
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
  Widget _buildTabBar() {
    var tabs = <Widget>[];
    // 将板块自己加进去
    var tab0 = Text(this.boardName, style: TextStyle(fontSize: 15),);
    tabs.add(tab0);

    if (childBoard == null)
      return TabBar(labelPadding: EdgeInsets.all(5), tabs: tabs, isScrollable: true,);
     // 将所有子版块加进来
    for (int i = 0; i < childBoard.length; i++) {
      var tab = Text(childBoard[i].board_name, style: TextStyle(fontSize: 15));
      tabs.add(tab);
    }
    return TabBar(labelPadding: EdgeInsets.all(5), tabs: tabs, isScrollable: true,);
  }

  // 构建Scallod的body
  List<Widget> _buildBody() {
    var result = <Widget>[];
    // 将该板块自己也加进去展示
    var item0 = BoardPostWidget(boardName, fid);
    result.add(item0);

    if (childBoard == null)
      return result;
    // 将所有子版块加进去
    for (int i = 0; i < childBoard.length; i++) {
      var item = BoardPostWidget(childBoard[i].board_name, childBoard[i].board_id);
      result.add(item);
    }
    return result;
  }
}
