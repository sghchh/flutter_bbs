import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/message.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/message/model.dart';
import 'package:flutter_bbs/pages/message/presenter.dart';
import 'package:flutter_bbs/utils/constant.dart' as ConstUtil;
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as UserCache;

/**
 * created by sgh     2019-2-28
 * 构建消息界面的"私信"界面
 */
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
        if (!snaphot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        } else {
          sourceData = snaphot.data.body.list;
          return ListView.builder(
              itemCount: sourceData.length,
              itemBuilder: (context, index){
                return Container(
                    margin: EdgeInsets.only(top: 6, bottom: 6),
                    padding: EdgeInsets.only(top: 6, left: 4, right: 4, bottom: 6),
                    child: Row(children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(sourceData[index].toUserAvatar),
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
                                Text(sourceData[index].toUserName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
                                Text(sourceData[index].lastDateline, style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.right,),
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 3, top: 4, right: 3),
                                child: Text(sourceData[index].lastSummary, style: TextStyle(fontSize: 12), textAlign: TextAlign.right,)
                            )
                          ],),
                      )
                    ],
                    )
                );

              });
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bindData(sourcedata) {
    return null;
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
    return null;
  }

  @override
  Future<MsgRespListPmse> toGetNetData() async {
    print("this is toGetNetData in private_stateful.dart------------");
    User finaluser = await UserCache.finalUser();
    var response = mPresenter.loadNetData (type: ConstUtil.MESSAGE_PMSE, query: { 'accessToken' : finaluser.token,
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
}