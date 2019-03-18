
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/message.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/message/model.dart';
import 'package:flutter_bbs/pages/message/presenter.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;
import 'package:flutter_bbs/utils/constant.dart' as const_util;

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

///created by sgh     2019-2-28
/// 构建消息界面的"系统消息"界面
class MessageSystemWidget extends StatefulWidget {

  MsgPresenterImpl _presenter;
  MsgModelImpl _model;
  _MsgViewImpl _view;

  MessageSystemWidget() : _presenter = MsgPresenterImpl(), _model = MsgModelImpl();

  @override
  State<StatefulWidget> createState() {
    _view = _MsgViewImpl();
    _view.setPresenter(_presenter);
    _presenter.bindView(_view);
    _presenter.bindModel(_model);
    return _view;
  }
}

class _MsgViewImpl extends State<MessageSystemWidget> with AutomaticKeepAliveClientMixin implements IBaseView {

  MsgPresenterImpl _presenter;

  List<System> sourceData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: toGetNetData(),
      builder: (context, snaphot) {
        //网络访问中
        if (!snaphot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        //网络错误
        if (snaphot.data.runtimeType == String) {
          return Text('error');
        }
        //成功得到数据
        sourceData = snaphot.data.body.data;
        return ListView.builder(
            itemCount: sourceData.length,
            itemBuilder: (context, index){
              return Container(
                  margin: EdgeInsets.only(top: 6, bottom: 6),
                  padding: EdgeInsets.only(top: 6, left: 4, right: 4, bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(right: 12, top: 10),
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(sourceData[index].icon),
                          radius: 24,
                        ),
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
                              Text(sourceData[index].user_name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
                              Text(sourceData[index].replied_date, style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.right,),
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 3, top: 4, right: 3),
                              child: Text(sourceData[index].note, style: TextStyle(fontSize: 12))
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
  }

  @override
  Future toGetMoreNetData() {
    return null;
  }

  @override
  Future toGetNetData() async {
    User finaluser = await user_cache.finalUser();
    var response = presenter.loadNetData (type: const_util.MESSAGE_SYSTEM, query: { 'accessToken' : finaluser.token,
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
}