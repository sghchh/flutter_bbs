import 'dart:convert' as convert;

import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// created by sgh     2019-3-11
/// HomePresenter中Presenter的最终实现类
class HomePresenterImpl extends IBasePresenter {
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future loadNetData({String type, Map<String, dynamic> query}) async{
    Response response = await model.onLoadNetData(type: type, query: query);
    if (response.statusCode == 200) {
      BBSRepListPost result = await compute(decodeResponse, response.data);
      return result;
    }
    view.showToast(response.statusCode);
    return 'error';
  }

  @override
  refresh({String type, Map<String, dynamic> query}) {
    return null;
  }
}

//后台解析json
BBSRepListPost decodeResponse(data) {
return BBSRepListPost.fromJson(convert.jsonDecode(data));
}