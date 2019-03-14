import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/forum.dart';

class BoardPresenterImpl extends IBasePresenter {

  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future loadNetData ({String type, Map<String, dynamic> query}) async {
    Response response = await mModel.onLoadNetData(type: type, query: query);
    if (response.statusCode == 200) {
      ForumListModel data = await compute(getForumListModel, response.data);
      return data;
    } else {
      mView.showToast(response.statusCode);
      return 'error';
    }
  }

  @override
  refresh({String type, Map<String, dynamic> query}) {
    return null;
  }

}

//后台解析responseBody的方法
ForumListModel getForumListModel (boady) {
var user = ForumListModel.fromJson(convert.jsonDecode(boady));
return user;
}