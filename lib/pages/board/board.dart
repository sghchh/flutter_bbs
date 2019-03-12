import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/forum.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/board/board_map.dart';
import 'package:flutter_bbs/constant.dart' as ConstUtil;
import 'package:flutter_bbs/pages/board/model.dart';
import 'package:flutter_bbs/pages/board/presenter.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as UserCache;


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
    this.view = BoardViewImpl();
    this.model = BoardModelImpl();
    presenter.bindView(view);
    presenter.bindModel(model);
    view.setPresenter(presenter);
  }
  
  @override
  State<StatefulWidget> createState() {
    return view;
  }
  
}

/**
 * BoardState是View层是实现类
 */
class BoardViewImpl extends State<BoardWidget> implements IBaseView {

  ForumListModel sourceData = null;    //源数据

  IBasePresenter _presenter;      //进行网络访问的Presenter

  @override
  Widget build(BuildContext context){
    return FutureBuilder<ForumListModel>(
      future: toGetNetData(),
      builder: (context, snaphot) {
        if (snaphot.hasData) {
          this.sourceData = snaphot.data;
          return CustomScrollView(
              slivers: MapUtil(sourceData.list).finalResult
          );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );

  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get mPresenter => _presenter;

  @override
  void setPresenter(presenter) {
    this._presenter = presenter;
  }

  @override
  void showToast(content) {
  }

  @override
  toGetMoreNetData() {
    mPresenter.loadNetData(type : ConstUtil.BOARD, query : {'accessToken' : 'accessToken', 'accessSecret' : 'accessSecret', 'sdkVersion' : 'sdkVersion', 'apphash' : 'apphash'});
  }

  @override
  Future<ForumListModel> toGetNetData() async{
    //print('this is BoardView toGetNetData and finalUser is ---------------${UserCache.finalUser.toString()}');
    User finaluser = await UserCache.finalUser();
    var response = await mPresenter.loadNetData (type: ConstUtil.BOARD, query: { 'accessToken' : finaluser.token,
      'accessSecret' :finaluser.secret,
      'apphash' : await UserCache.getAppHash(),
      'sdkVersion' : '2.5.0.0'
    });
    return response;
  }

  @override
  toRefresh() {
    return null;
  }

  @override
  bindData(sourcedata) {
    //print("this is bindData in BoardView ---------------${sourcedata.toString()}");
    setState(() {
      this.sourceData = sourcedata;
    });
  }
}
