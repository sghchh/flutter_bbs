
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/board.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/board/board_map.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/pages/board/model.dart';
import 'package:flutter_bbs/pages/board/presenter.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;

import 'package:flutter/material.dart';


class BoardPageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '清水河畔',
      home: Scaffold(
        appBar: AppBar(
          title: Text('板块列表'),
          centerTitle: true,
        ),
        body: BoardWidget(),
      ),
    );
  }
}

class BoardWidget extends StatefulWidget {

  BoardPresenterImpl presenter;      //Presenter的实现类
  BoardViewImpl view;               //View的实现类
  BoardModelImpl model;            //Model的实现类

  BoardWidget() {
    this.presenter = BoardPresenterImpl();
    this.model = BoardModelImpl();
  }
  
  @override
  State<StatefulWidget> createState() {
    this.view = BoardViewImpl();
    presenter.bindView(view);
    presenter.bindModel(model);
    view.setPresenter(presenter);
    return view;
  }
  
}

///BoardState是View层是实现类
class BoardViewImpl extends State<BoardWidget> implements IBaseView {

  ForumListModel sourceData;    //源数据

  IBasePresenter _presenter;      //进行网络访问的Presenter

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: toGetNetData(),
      builder: (context, snaphot) {

        if (!snaphot.hasData)
          return Center(child: CircularProgressIndicator(),);

        if (snaphot.data.runtimeType == String)
          return Center(child: Text('error'),);

        // 代表没有从服务器获取数据，一般是参数异常导致的
        //if ( snaphot.data.head.errCode != const_util.success)
         // return Center(child: Text("${snaphot.data.head.errCode} : ${snaphot.data.head.errInfo}"),);

        this.sourceData = snaphot.data;
        return CustomScrollView(
            slivers: MapUtil(sourceData.list, context).finalResult
        );
      },
    );

  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get presenter => _presenter;

  @override
  void setPresenter(presenter) {
    this._presenter = presenter;
  }

  @override
  void showToast(content) {
    var snackBar = SnackBar(
      content: Text("${content}"),
      duration: Duration(milliseconds: 1500),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  toGetMoreNetData() {
    presenter.loadNetData(type : const_util.BOARD, query : {'accessToken' : 'accessToken', 'accessSecret' : 'accessSecret', 'sdkVersion' : 'sdkVersion', 'apphash' : 'apphash'});
  }

  @override
  Future toGetNetData() async{
    User finaluser = await user_cache.finalUser();
    var response = presenter.loadNetData (type: const_util.board_boardList, query: { 'accessToken' : finaluser.token,
      'accessSecret' :finaluser.secret,
      'apphash' : await user_cache.getAppHash(),
      'sdkVersion' : '2.5.0.0'
    });
    return response;
  }

  @override
  toRefresh() {
    return null;
  }

  @override
  bindData(sourcedata, type) {
    //print("this is bindData in BoardView ---------------${sourcedata.toString()}");
    setState(() {
      this.sourceData = sourcedata;
    });
  }
}
