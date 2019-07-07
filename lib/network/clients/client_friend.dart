
import 'package:dio/dio.dart';
import 'package:flutter_bbs/network/http_client.dart';

class FriendClient {
  static final _friendInfo = "/app/web/index.php?r=user/userinfo";    //获取好友信息的路径
  static final _friendPublish = "/app/web/index.php?r=user/topiclist";    // 获取好友发表的路径
  static final Dio _dioClient = DioClient.getInstance();

  //获取好友已发表的方法
  static Future getFriendPublished (Map<String, dynamic> query) async {
    var response;
    try {
      response = await _dioClient.post(_friendPublish, queryParameters: query);
    } on DioError catch(e) {
      if (e.response != null)
        print(e.response.statusCode);
      response = e.response;
    }
    print(response.runtimeType);
    return response;
  }

  //获取好友信息的方法
  static Future getFriendInfo(Map<String, dynamic> query) async {
    var response;
    try {
      response = await _dioClient.post(_friendInfo, queryParameters: query);
    } on DioError catch(e) {
      if (e.response != null)
        print(e.response.statusCode);
      response = e.response;
    }
    return response;
  }
}