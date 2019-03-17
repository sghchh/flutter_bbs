import 'dart:convert' as convert;

import 'package:flutter_bbs/pages/user/model.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserPresenterImpl extends IBasePresenter {
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future loadNetData({String type, Map<String, dynamic> query}) async{
    Response response;
    response = await model.onLoadNetData(type: type, query: query);
    if (response.statusCode != 200) {
      view.showToast(response.statusCode);
      return 'error';
    }

    BBSRespListUserPub result;

    switch(type) {
      case const_util.user_favourite:
        result = await compute(_decodeUserPublish, response.data);
        break;
      case const_util.user_publish:
        result = await compute(_decodeUserPublish, response.data);
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
}