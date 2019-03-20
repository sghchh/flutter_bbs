import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/message.dart';

import 'package:dio/dio.dart';

///ceated by sgh     2019-3-12
///消息界面中的Presenter的实现类
class MsgPresenterImpl extends IBasePresenter {
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future loadNetData({String type, Map<String, dynamic> query}) async{
    Response response = await model.onLoadNetData(type: type, query: query);
    if (response.statusCode == 200) {
      switch (type) {
        case const_util.MESSAGE_PMSE:
          MsgRespListPmse result = await compute(_decodePmseRes, response.data);
          return result;
        case const_util.MESSAGE_ATME:
          MsgRespListAtMe result = await compute(_decodeAtMeRes, response.data);
          return result;
        case const_util.MESSAGE_REPLY:
          MsgRespListReply result = await compute(_decodeReplyRes, response.data);
          return result;
        case const_util.MESSAGE_SYSTEM:
          MsgRespListSystem result = await compute(_decodeSysRes, response.data);
          return result;
      }
    }
    view.showToast("Http error : ${response.statusCode}");
    return 'error';
  }

  @override
  refresh({String type, Map<String, dynamic> query}) {
    return null;
  }

}

//后台解析 私信 的json
MsgRespListPmse _decodePmseRes(response) {
  return MsgRespListPmse.fromJson(convert.jsonDecode(response));
}

//后台解析 系统消息 的json
MsgRespListSystem _decodeSysRes(response) {
  return MsgRespListSystem.fromJson(convert.jsonDecode(response));
}

//后台解析 @我 的json
MsgRespListAtMe _decodeAtMeRes(response) {
  return MsgRespListAtMe.fromJson(convert.jsonDecode(response));
}

//后台解析 帖子回复 的json
MsgRespListReply _decodeReplyRes(response) {
  return MsgRespListReply.fromJson(convert.jsonDecode(response));
}