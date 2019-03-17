import 'package:flutter_bbs/network/http_client.dart';

import 'package:dio/dio.dart';

/// 用来获取User界面中数据的Client类
class UserClient {
  static final _userPublishPath = "/app/web/index.php?r=user/topiclist&pageSize=200";    //获取“我的收藏”和“我的发表”的路径
  static final _userFriendsPath = "/app/web/index.php?r=user/userlist/";            //获取好友列表的路径
  static final Dio _dioClient = DioClient.getInstance();

  //获取已发表的方法
  static Future getUserPublished (Map<String, dynamic> query) async {
    var type = 'topic';
    final response = await _dioClient.post(_userPublishPath, queryParameters: query);
    return response;
  }

  //获取我的收藏的方法
  static Future<Response> getUserFavorite (Map<String, dynamic> query) async {
    var response = await _dioClient.post(_userPublishPath, queryParameters: query);
    return response;
  }

  //获取好友列表
  static Future<Response> getUserFriends(Map<String, dynamic> query) async{
    final response = await _dioClient.post(_userFriendsPath, queryParameters: query);
    return response;
  }
}