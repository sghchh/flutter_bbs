
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/network/clients/client_board.dart';
import 'package:flutter_bbs/network/json/forum.dart';

class BoardModel extends IBaseModel {

  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) {
  }

  @override
  Future<ForumListModel> onLoadNetData({String type, Map<String, dynamic> query}) async{
    print("this is onLoadNetData in BoardModel");
    var f = await BoardClient.getForumList(query: query);
    return f;
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) {
  }

}