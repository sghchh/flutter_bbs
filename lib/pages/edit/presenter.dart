import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:flutter_bbs/return_type.dart';
import 'dart:convert' as convert;
import 'package:flutter_bbs/utils/constant.dart' as const_util;

import 'package:flutter_bbs/pages/edit/model.dart';

class EditPresenterImpl extends IBasePresenter{
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future loadNetData({String type, Map<String, dynamic> query}) async {
    Response response = await model.onLoadNetData(query: query);
    if (response.statusCode == 200) {
      BBSRepListPost data = await compute(_decodeResponse, response.data);
      return data;
    }
    view.showToast("Http error : ${response.statusCode}");
    return "error";
  }

  @override
  refresh({String type, Map<String, dynamic> query}) async{
    Response response = await model.onLoadNetData(query: query);
    if (response.statusCode == 200) {
      BBSRepListPost data = await compute(_decodeResponse, response.data);
      view.bindData(data, "refresh");
      return;
    }
    view.showToast("Http error : ${response.statusCode}");
  }

  publish(Map query) async{
    Response response = await (model as EditModelImpl).publish(query);
    if (response.statusCode == 200) {
      BBSResponse data = await compute(_decodePublish, response.data);
      if (data.head.errCode == const_util.success) {
        ReturnType type = ReturnType(1, content: "发表成功");
        return type;
      }
      // 说明是参数错误
      ReturnType type = ReturnType(0, content: "${data.head.errCode} : ${data.head.errInfo}");
      return type;
    }
    ReturnType type = ReturnType(0, content: "Http error : ${response.statusCode}");
    return type;
  }

  comment(Map query) async{
    Response response = await (model as EditModelImpl).comment(query);
    if (response.statusCode == 200) {
      BBSResponse data = await compute(_decodePublish, response.data);
      if (data.head.errCode == const_util.success) {
        ReturnType type = ReturnType(1, content: "发表成功");
        return type;
      }
      // 说明是参数错误
      ReturnType type = ReturnType(0, content: "${data.head.errCode} : ${data.head.errInfo}");
      return type;
    }
    ReturnType type = ReturnType(0, content: "Http error : ${response.statusCode}");
    return type;
  }

  static BBSRepListPost _decodeResponse(data) {
    return BBSRepListPost.fromJson(convert.jsonDecode(data));
  }

  static BBSResponse _decodePublish(data) {
    return BBSResponse.fromJson(convert.jsonDecode(data));
  }
}