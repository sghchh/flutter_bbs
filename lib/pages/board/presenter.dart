import 'dart:convert' as convert;

import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/network/json/board.dart';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class BoardPresenterImpl extends IBasePresenter {

  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future loadNetData ({String type, Map<String, dynamic> query}) async {
    Response response = await model.onLoadNetData(type: type, query: query);
    if (response.statusCode == 200) {
      //print("这是presenter${response.data.toString()}");
      var data;
      switch (type){
        case const_util.board_boardList:
          data = await compute(getForumListModel, response.data);
          break;
        case const_util.board_childBoard:
          data = await compute(_decodeBoard, response.data);
          break;
      }
      return data;
    } else {
      view.showToast("Http error : ${response.statusCode}");
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

// 后台解析
ChildBoardInfoResponse _decodeBoard(body) {
  var result = ChildBoardInfoResponse.fromJson(convert.jsonDecode(body));
  return result;
}