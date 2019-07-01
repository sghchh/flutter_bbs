import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/user/model.dart';
import 'package:flutter_bbs/pages/user/presenter.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;
import 'package:flutter_bbs/utils/constant.dart' as const_util;

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FriendsWidget extends StatefulWidget {

  UserPresenterImpl _presenter;
  UserModelImpl _model;
  _FriendsViewImpl _view;

  FriendsWidget() : _presenter = UserPresenterImpl(), _model = UserModelImpl();

  @override
  State<StatefulWidget> createState() {
    _view = _FriendsViewImpl();
    _presenter.bindView(_view);
    _presenter.bindModel(_model);
    _view.setPresenter(_presenter);
    return _view;
  }
}

class _FriendsViewImpl extends State<FriendsWidget> implements IBaseView{

  UserPresenterImpl _presenter;

  List<ListBean> sourceData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: toGetNetData(),
      builder: (context, snaphot) {
        if (!snaphot.hasData)
          return Center(child: CircularProgressIndicator(),);

        // 该情况代表http错误
        if (snaphot.data.runtimeType == String)
          return Center(child: Text('error'),);

        // 代表没有从服务器获取数据，一般是参数异常导致的
        if ( snaphot.data.head.errCode != const_util.success)
          return Center(child: Text("${snaphot.data.head.errCode} : ${snaphot.data.head.errInfo}"),);

        sourceData = snaphot.data.list;
        return ListView.builder(
          itemCount: sourceData.length,
          itemBuilder: (context, index) {
            return ListTile(
              isThreeLine: true,
              subtitle: Text(sourceData[index].signature, style: TextStyle(fontSize: 14, color: Colors.grey)),
              leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(sourceData[index].icon), radius: 24,),
              title: Text(sourceData[index].name,style: TextStyle(fontSize: 18)),
              onTap: null,  // 需要跳转到好友信息界面
            );
          },
        );
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
    User finalUser = await user_cache.finalUser();
    var response = presenter.loadNetData(type: const_util.user_friends, query: {
      "page" : 1,
      "type" : const_util.userFriendsType,
      "accessToken" : finalUser.token,
      "accessSecret" : finalUser.secret,
      "apphash" : await user_cache.getAppHash(),
      "sdkVersion" : const_util.sdkVersion
    });
    return response;
  }

  @override
  toRefresh() {
    return null;
  }

}