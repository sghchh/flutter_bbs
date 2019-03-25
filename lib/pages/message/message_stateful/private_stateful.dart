
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/message.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/message/model.dart';
import 'package:flutter_bbs/pages/message/presenter.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;
import 'package:flutter_bbs/utils/time_util.dart' as time_util;

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

///created by sgh     2019-2-28
/// 构建消息界面的"私信"界面
class MessagePrivateWidget extends StatefulWidget {

  MsgPresenterImpl _presenter;
  MsgModelImpl _model;
  _MsgViewImpl _view;

  MessagePrivateWidget() : this._presenter = MsgPresenterImpl(), this._model = MsgModelImpl();

  @override
  State<StatefulWidget> createState() {
    _view = _MsgViewImpl();
    _presenter.bindView(_view);
    _presenter.bindModel(_model);
    _view.setPresenter(_presenter);
    return _view;
  }
}

class _MsgViewImpl extends State<MessagePrivateWidget> with AutomaticKeepAliveClientMixin implements IBaseView {

  MsgPresenterImpl _presenter;
  List<PmseMission> sourceData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: toGetNetData(),
      builder: (context, snaphot) {
        //网络请求中
        if (!snaphot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        // 该情况代表http错误
        if (snaphot.data.runtimeType == String)
          return Center(child: Text('error'),);

        // 代表没有从服务器获取数据，一般是参数异常导致的
        if ( snaphot.data.head.errCode != const_util.success)
          return Center(child: Text("${snaphot.data.head.errCode} : ${snaphot.data.head.errInfo}"),);

          sourceData = snaphot.data.body.list;
          return ListView.builder(
              itemCount: sourceData.length,
              itemBuilder: (context, index){
                return Container(
                    margin: EdgeInsets.only(top: 6, bottom: 6),
                    padding: EdgeInsets.only(top: 6, left: 4, right: 4, bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 12, top: 10),
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(sourceData[index].toUserAvatar),
                          radius: 24,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(sourceData[index].toUserName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                                Text(time_util.decodeTime(sourceData[index].lastDateline), style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.right,),
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 3, top: 4, right: 3),
                                child: Text(sourceData[index].lastSummary, style: TextStyle(fontSize: 14),)
                            )
                          ],),
                      )
                    ],
                    )
                );

              });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

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
  void showToast(content) {
    var snackBar = SnackBar(
      content: Text("${content}"),
      duration: Duration(milliseconds: 1500),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  toGetMoreNetData() {
    return null;
  }

  @override
  Future toGetNetData() async {
    User finaluser = await user_cache.finalUser();
    var response = presenter.loadNetData (type: const_util.MESSAGE_PMSE, query: { 'accessToken' : finaluser.token,
      'accessSecret' :finaluser.secret,
      'apphash' : await user_cache.getAppHash(),
      'sdkVersion' : const_util.sdkVersion
    });
    return response;
  }

  @override
  toRefresh() {
    return null;
  }
}