import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:flutter_bbs/network/json/friend.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter/foundation.dart';

class FriendPresenterImpl extends IBasePresenter {
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
      case const_util.friend_published:
        result = await compute(_decodeFriendPublished, response.data);
        break;
    }
    print("this is presenter end : ${result.runtimeType}");
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
      case const_util.friend_published:
        result = await compute(_decodeFriendPublished, response.data);
        break;
      case const_util.friend_infor:
        result = await compute(_decodeFriendInfor, response.data);
        break;
    }
    return result;
  }

  @override
  refresh({String type, Map<String, dynamic> query}) async{
    Response response = await model.onRefresh(type: type, query: query);
    if (response.statusCode == 200) {
      BBSRepListPost result = await compute(_decodeFriendPublished, response.data);
      view.bindData(result, const_util.refresh);
    } else {
      view.showToast(response.statusCode);
    }
  }

  static FriendInforResponse _decodeFriendInfor(dynamic data) {
    return FriendInforResponse.fromJson(convert.jsonDecode(data));
  }

  static BBSRepListPost _decodeFriendPublished(dynamic data) {
    return BBSRepListPost.fromJson(convert.jsonDecode(data));
  }

}