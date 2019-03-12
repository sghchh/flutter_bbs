
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';

/**
 * created by sgh     2019-3-11
 * HomePresenter中Presenter的最终实现类
 */
class HomePresenterImpl extends IBasePresenter {
  @override
  loadMoreNetData({String type, Map<String, dynamic> query}) {
    return null;
  }

  @override
  Future<BBSRepListPost> loadNetData({String type, Map<String, dynamic> query}) async{
    return await mModel.onLoadNetData(type: type, query: query);
  }

  @override
  refresh({String type, Map<String, dynamic> query}) {
    return null;
  }

}