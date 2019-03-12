
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/forum.dart';

class BoardPresenterImpl extends IBasePresenter {

  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future<ForumListModel> loadNetData ({String type, Map<String, dynamic> query}) async {
    //print("this is loadNetData----------------${query.toString()}");

    ForumListModel data = await mModel.onLoadNetData(type: type, query: query);
    return data;
    //mView.bindData(data);
  }

  @override
  refresh({String type, Map<String, dynamic> query}) {
    return null;
  }

}