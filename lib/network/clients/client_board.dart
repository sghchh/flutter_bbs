import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter_bbs/network/http_client.dart';
import 'package:flutter_bbs/network/json/forum.dart';

class BoardClient {
  static final _formlistPath = "/app/web/index.php?r=forum/forumlist";    //获取板块列表的path

  static final _dioClient = DioClient.getInstance();        //进行网络请求的真实的客户端

  //获取板块列表的方法
  static Future<ForumListModel> getForumList ({query}) async{
    var result;
    final response = await _dioClient.post(_formlistPath, queryParameters: query);
    if(response.statusCode == 200) {
      //print("this is getForumList in client_board----------------:${response.data.toString()}");
      result = await compute(getForumListModel, response.data);
      return result;
    }
    return result;
  }

  //后台解析responseBody的方法
  static ForumListModel getForumListModel (boady) {
    var user = ForumListModel.fromJson(convert.jsonDecode(boady));
    return user;
  }
}