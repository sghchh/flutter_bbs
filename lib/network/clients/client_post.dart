
import 'package:flutter_bbs/network/http_client.dart';

import 'package:dio/dio.dart';


/// 负责“帖子详情”的请求
class PostClient {

  static final String _postDetailPath = "/app/web/index.php?r=forum/postlist&pageSize=25";          //获取帖子详情的路径

  static final Dio _dioClient = DioClient.getInstance();


  Future getPostDetail(Map query) async {
    final response = await _dioClient.post(_postDetailPath, queryParameters: query);
    return response;
  }
}