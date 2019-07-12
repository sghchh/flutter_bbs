import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/search.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'dart:convert' as convert;
class SearchPresenterImpl extends IBasePresenter {
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
      case const_util.search_topic:
        result = await compute(_decodeSearchTopic, response.data);
        if (result.list == null || result.list.length == 0){
          view.bindData(result, const_util.noMore);
        }
        break;
      case const_util.search_user:
        result = await compute(_decodeSearchUser, response.data);
        if (result.body.list == null || result.body.list.length == 0){
          view.bindData(result, const_util.noMore);
        }
        break;
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
      case const_util.search_topic:
        result = await compute(_decodeSearchTopic, response.data);
        view.bindData(result, 0);
        break;
      case const_util.search_user:
        result = await compute(_decodeSearchUser, response.data);
        view.bindData(result, 0);
        break;
    }
    return result;
  }

  @override
  refresh({String type, Map<String, dynamic> query}) async{
    Response response = await model.onRefresh(type: type, query: query);
    if (response.statusCode == 200) {
      var result;
      if (type == const_util.search_topic)
        result = await compute(_decodeSearchTopic, response.data);
      else
        result = await compute(_decodeSearchUser, response.data);
      view.bindData(result, const_util.refresh);
    } else {
      view.showToast(response.statusCode);
    }
  }

  static SearchTopicResponse _decodeSearchTopic(dynamic data) {
    return SearchTopicResponse.fromJson(convert.jsonDecode(data));
  }

  static SearchUserResponse _decodeSearchUser(dynamic data) {
    return SearchUserResponse.fromJson(convert.jsonDecode(data));
  }
}