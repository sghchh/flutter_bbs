import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/network/http_client.dart';
import 'package:flutter_bbs/network/json/message.dart';

class MsgClient {
  static final String postMsg = '/app/web/index.php?r=message/notifylistex&type=post&pageSize=100';
  static final String atMe = '/app/web/index.php?r=message/notifylistex&type=at&pageSize=100';
  static final String system = '/app/web/index.php?r=message/notifylistex&type=system&pageSize=100';
  static final String pmseMsg = '/app/web/index.php?r=message/pmsessionlist';

  static final Dio _dioClient = DioClient.getInstance();


  //获取已发消息的方法
  static Future<MsgRespListPmse> getPostMsg(Map<String, dynamic> query) async {
    var json = "{'page': 1, 'pageSize': 100}";
    var newQuery = <String, String>{'json' : json, 'apphash' : query['apphash'], 'accessToken' : query['accessToken'], 'accessSecret' : query['accessSecret'], 'sdkVersion' : query['sdkVersion']};
    final response = await _dioClient.post(pmseMsg, queryParameters: newQuery);
    var result;
    if (response.statusCode == 200) {
      result = await compute(decodeResponse, response.data);
      return result;
    }
    return result;
  }

  static MsgRespListPmse decodeResponse(response) {
    return MsgRespListPmse.fromJson(convert.jsonDecode(response));
  }
}