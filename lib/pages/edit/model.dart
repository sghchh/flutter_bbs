import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/network/clients/client_edit.dart';

class EditModelImpl extends IBaseModel {
  @override
  Future onLoadMoreData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future onLoadNetData({String type, Map<String, dynamic> query}) async{
    return await EditClient.getClassificationTypeList(query);
  }

  @override
  Future onRefresh({String type, Map<String, dynamic> query}) {
    return null;
  }

  publish (Map query) async{
    return await EditClient.publish(query);
  }

  comment(Map query) async {
    return await EditClient.publish(query);
  }
}