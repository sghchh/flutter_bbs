import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/network/clients/client_search.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;
class SearchModelImpl extends IBaseModel {
  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) async{
    var result;
    switch (type) {
      case const_util.search_topic:
        result = await SearchClient.searchTopic(query);
        break;
      case const_util.search_user:
        result = await SearchClient.searchUser(query);
        break;
    }
    return result;
  }

  @override
  Future onLoadNetData({String type, Map<String, dynamic> query}) async{
    var result;
    switch (type) {
      case const_util.search_topic:
        result = await SearchClient.searchTopic(query);
        break;
      case const_util.search_user:
        result = await SearchClient.searchUser(query);
        break;
    }
    return result;
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) async{
    var result;
    switch (type) {
      case const_util.search_topic:
        result = await SearchClient.searchTopic(query);
        break;
    }
    return result;
  }
}