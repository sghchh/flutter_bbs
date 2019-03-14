import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/network/http_client.dart';
import 'package:flutter_bbs/network/json/forum.dart';

class BoardClient {
  static final _formlistPath = "/app/web/index.php?r=forum/forumlist";    //获取板块列表的path

  static final _dioClient = DioClient.getInstance();        //进行网络请求的真实的客户端

  //获取板块列表的方法
  static Future<Response> getForumList ({query}) async{
    final response = await _dioClient.post(_formlistPath, queryParameters: query);
    return response;
  }

}