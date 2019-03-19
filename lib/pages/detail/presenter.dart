import 'dart:convert' as convert;

import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


/// 帖子详情界面的Presenter
class PostPresenterImpl extends IBasePresenter {
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) async{
    Response response = await model.onLoadNetData(query: query);
    if (response.statusCode == 200) {
      PostDetailResponse result = await compute(_decodeResponse, response.data);
      if (result.list.length > 0) {
        view.bindData(result, const_util.loadMore);
      } else {
        //表示没有更多数据了
        view.bindData(result, const_util.noMore);
      }
    }else {
      view.showToast(response.statusCode);
    }
  }

  @override
  Future loadNetData({String type, Map<String, dynamic> query}) async{
    Response response = await model.onLoadNetData(query: query);
    if (response.statusCode == 200) {
      PostDetailResponse data = await compute(_decodeResponse, response.data);
      return data;
    }
    view.showToast(response.statusCode);
    return "error";
  }

  @override
  refresh({String type, Map<String, dynamic> query}) {
    return null;
  }

  //后台解析json
  static PostDetailResponse _decodeResponse(response) {
    return PostDetailResponse.fromJson(convert.jsonDecode(response));
  }
}