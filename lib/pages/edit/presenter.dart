import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'dart:convert' as convert;

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
    print("这里是presenter}");
    Response response = await (model as EditModelImpl).publish(query);
    print("这里是presenter${response.data.toString()}");
    if (response.statusCode == 200) {
      BBSResponse data = await compute(_decodePublish, response.data);
      view.showToast("${data.head.errCode} : ${data.head.errInfo}");
      return;
    }
    view.showToast("Http error : ${response.statusCode}");
  }

  static BBSRepListPost _decodeResponse(data) {
    return BBSRepListPost.fromJson(convert.jsonDecode(data));
  }

  static BBSResponse _decodePublish(data) {
    return BBSResponse.fromJson(convert.jsonDecode(data));
  }
}