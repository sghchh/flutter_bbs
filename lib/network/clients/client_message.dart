
import 'package:flutter_bbs/network/http_client.dart';

import 'package:dio/dio.dart';

class MsgClient {
  static final String replyMsg = '/app/web/index.php?r=message/notifylistex&type=post&pageSize=100';
  static final String atMe = '/app/web/index.php?r=message/notifylistex&type=at&pageSize=100';
  static final String system = '/app/web/index.php?r=message/notifylistex&type=system&pageSize=100';
  static final String pmseMsg = '/app/web/index.php?r=message/pmsessionlist';

  static final Dio _dioClient = DioClient.getInstance();


  //获取私信的方法
  static Future getPostMsg(Map<String, dynamic> query) async {
    var json = "{'page': 1, 'pageSize': 100}";
    var newQuery = <String, String>{'json' : json, 'apphash' : query['apphash'], 'accessToken' : query['accessToken'], 'accessSecret' : query['accessSecret'], 'sdkVersion' : query['sdkVersion']};
    final response = await _dioClient.post(pmseMsg, queryParameters: newQuery);
    return response;
  }

  //获取系统消息的方法
  static Future getSystemMsg (Map<String, dynamic> query) async {
    final response = await _dioClient.post(system, queryParameters: query);
    return response;
  }

  //获取帖子回复的方法
  static Future getReplyMsg(Map<String, dynamic> query) async {
    final response = await _dioClient.post(replyMsg, queryParameters: query);
    return response;
  }

  //获取@我的方法
  static Future getAtMeMsg(Map<String, dynamic> query) async {
    final response = await _dioClient.post(atMe, queryParameters: query);
    return response;
  }
}