
import 'package:flutter_bbs/network/http_client.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

/**
 * created by sgh     2019-3-3
 * 负责Home界面的网络请求的客户端
 */
class HomeClient {

  static final NEWREPLY = "app/web/index.php?r=forum/topiclist&pageSize=10";    //"最新回复"网络请求的path
  static final TODAYHOT = "app/web/index.php?r=portal/newslist&moduleId=2";     //"今日热点"网络请求的path
  static final NEWPUBLISH = "app/web/index.php?r=forum/topiclist&pageSize=10";  //"最新发表"网络请求的path  和最新回复的区别是参数多了一个sortby = new

  static Dio _client = DioClient.getInstance();    //真正的网络请求的客户端

  //获取"最新回复"的数据
  _getNewReply({@required int page, @required String accessToken, @required String apphash, @required String accessSecret}) {}

  //获取"今日热点"的数据
  _getTodayHot({@required int page, @required String accessToken, @required String apphash, @required String accessSecret}) {}

  //获取"最新发表"的数据
  _getNewPublish({@required int page, @required String sortBy, @required String accessToken, @required String apphash, @required String accessSecret}){}

}