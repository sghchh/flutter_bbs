import 'dart:convert' as convert;

import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserPresenterImpl extends IBasePresenter {
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) async{
    Response response;
    response = await model.onLoadMoreData(type: type, query: query);
    if (response.statusCode != 200) {
      view.showToast("Http error : ${response.statusCode}");
      return;
    }
    var result;
    switch(type) {
      case const_util.user_favourite:
        result = await compute(_decodeUserPublish, response.data);
        break;
      case const_util.user_publish:
        result = await compute(_decodeUserPublish, response.data);
        break;
      case const_util.user_friends:
        result = await compute(_decodeUserFriends, response.data);
        break;
    }
    if (result.list.length == 0){
      view.bindData(result, const_util.noMore);
    }
    view.bindData(result, const_util.loadMore);
  }

  @override
  Future loadNetData({String type, Map<String, dynamic> query}) async{
    Response response;
    response = await model.onLoadNetData(type: type, query: query);
    if (response.statusCode != 200) {
      view.showToast("Http error : ${response.statusCode}");
      return 'error';
    }
    var result;
    switch(type) {
      case const_util.user_favourite:
        result = await compute(_decodeUserPublish, response.data);
        break;
      case const_util.user_publish:
        result = await compute(_decodeUserPublish, response.data);
        break;
      case const_util.user_friends:
        result = await compute(_decodeUserFriends, response.data);
        break;
    }
    return result;
  }

  @override
  refresh({String type, Map<String, dynamic> query}) {
    return null;
  }

  //后台解析“我的发表”返回的json
  static BBSRespListUserPub _decodeUserPublish(response) {
    return BBSRespListUserPub.fromJson(convert.jsonDecode(response));
  }

  //后台解析“好友列表”返回的json
  static UserList _decodeUserFriends(response) {
    return UserList.fromJson(convert.jsonDecode(response));
  }
}