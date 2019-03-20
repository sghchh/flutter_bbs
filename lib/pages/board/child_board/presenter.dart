
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';

class BoardChildPostPreImpl extends IBasePresenter {
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) async{
    Response response = await model.onLoadMoreData(type: type, query: query);
    if (response.statusCode == 200) {
      BBSRepListPost result = await compute(decodeResponse, response.data);
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
    Response response = await model.onLoadNetData(type: type, query: query);
    if (response.statusCode == 200) {
      BBSRepListPost result = await compute(decodeResponse, response.data);
      return result;
    }
    view.showToast(response.statusCode);
    print("将要返回error");
    return 'error';
  }

  @override
  refresh({String type, Map<String, dynamic> query}) async {
    Response response = await model.onRefresh(type: type, query: query);
    if (response.statusCode == 200) {
      BBSRepListPost result = await compute(decodeResponse, response.data);
      view.bindData(result, const_util.refresh);
    } else {
      view.showToast(response.statusCode);
    }
  }
}

//后台解析json
BBSRepListPost decodeResponse(data) {
  return BBSRepListPost.fromJson(convert.jsonDecode(data));
}