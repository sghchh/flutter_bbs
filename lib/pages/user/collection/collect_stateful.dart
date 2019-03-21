import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/detail/detail.dart';
import 'package:flutter_bbs/pages/user/model.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/pages/user/presenter.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;
import 'package:flutter_bbs/utils/constant.dart' as const_util;

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

///created by sgh    2019-2-26
/// 用户信息中“我的收藏”的界面
class CollectionWidget extends StatefulWidget {

  UserPresenterImpl _presenter;
  UserModelImpl _model;
  _CollectionState _view;

  CollectionWidget() : _presenter = UserPresenterImpl(), _model = UserModelImpl();

  @override
  State<StatefulWidget> createState() {
    _view = _CollectionState();
    _presenter.bindView(_view);
    _presenter.bindModel(_model);
    _view.setPresenter(_presenter);
    return _view;
  }
}

class _CollectionState extends State<CollectionWidget> implements IBaseView {

  UserPresenterImpl _presenter;

  List<UserPublish> sourceData;

  ScrollController _scrollController;       //用来控制List的滚动，实现上拉加载

  bool isLoading = false;       //表示是否正在进行加载操作
  bool hasMore = true;        //表示是否还有数据
  int page = 1;              //表示页数

  _CollectionState() : this._scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!isLoading && hasMore) {
          toGetMoreNetData();
          setState(() {
            isLoading = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (sourceData == null)
      return _initBuild();
    return _buildList();
  }

  // 初始加载时构建界面
  Widget _initBuild() {
    return FutureBuilder(
      future: toGetNetData(),
      builder: (context, snaphot) {

        if (!snaphot.hasData)
          return Center(child: CircularProgressIndicator(),);

        // 该情况代表http错误
        if (snaphot.data.runtimeType == String)
          return Center(child: Text('error'),);

        // 代表没有从服务器获取数据，一般是参数异常导致的
        if ( snaphot.data.head.errCode != const_util.success)
          return Center(child: Text("${snaphot.data.head.errCode} : ${snaphot.data.head.errInfo}"),);

        this.sourceData = snaphot.data.list;
        hasMore = snaphot.data.has_next == 0 ? false : true;
        return _buildList();
      },
    );
  }

  // 构建list项
  Widget _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (index == sourceData.length)
          return _buildLoadMore();
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){

              //点击跳转到帖子详情的界面
              return DetailPageWidget(sourceData[index].topic_id);
            }));},
          child: Container(
            padding: const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 8),
            margin: const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 12),
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(sourceData[index].userAvatar),
                    radius: 30,
                  ),
                ),
                Flexible(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(sourceData[index].user_nick_name, style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                        Text(sourceData[index].board_name,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          textAlign: TextAlign.right,),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(sourceData[index].last_reply_date,
                            style: TextStyle(fontSize: 12, color: Colors.grey))
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(sourceData[index].subject,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(Icons.remove_red_eye, size: 18, color: Colors.grey,),
                        Container(
                          margin: const EdgeInsets.only(left: 6, right: 6),
                          child: Text(sourceData[index].hits.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ),
                        Icon(Icons.chat_bubble_outline, size: 18,
                          color: Colors.grey,),
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          child: Text(sourceData[index].replies.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ),
                      ],
                    )
                  ],
                ),)
              ],
            ),
          ),
        );
      },
      itemCount: sourceData.length + 1,
    );
  }

  //构建加载更多的widget
  Widget _buildLoadMore() {
    if (isLoading) {
      return Container(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 6),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
              Text(
                "正在加载数据...",
                style: TextStyle(color: Colors.lightBlueAccent),
              )
            ],
          ),
        ),
      );
    }
    if (!hasMore) {
      return Container(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        child: Center(
          child: Text("没有更多了~~", style: TextStyle(color: Colors.blueGrey)),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Center(
        child: Text("上拉加载更多...", style: TextStyle(color: Colors.blueGrey)),
      ),
    );
  }

  @override
  bindData(sourcedata, type) {
    setState(() {
      if (type == const_util.loadMore) {
        page++;
        this.sourceData.addAll(sourcedata.list);
      } else if (type == const_util.refresh) {
        page = 1;
        this.sourceData = sourcedata.list;
      }
      hasMore = sourcedata.hasNext == 0 ? false : true;
      isLoading = false;
    });
  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get presenter => _presenter;

  @override
  void setPresenter(presenter) {
    _presenter = presenter;
  }

  @override
  void showToast(content) {
    var snackBar = SnackBar(
      content: Text("${content}"),
      duration: Duration(milliseconds: 1500),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  toGetMoreNetData() async{
    User finalUser = await user_cache.finalUser();
    presenter.loadMoreNetData(type: const_util.user_favourite,query: {"type" : const_util.userFavoriteType,
      "uid" : finalUser.uid,
      "apphash" : await user_cache.getAppHash(),
      "accessToken" : finalUser.token,
      "accessSecret" : finalUser.secret,
      "page" : page + 1,
      "sdkVersion" : const_util.sdkVersion
    });
  }

  @override
  Future toGetNetData() async {
    User finalUser = await user_cache.finalUser();
    var data = presenter.loadNetData(type: const_util.user_favourite,query: {"type" : const_util.userFavoriteType,
      "uid" : finalUser.uid,
      "apphash" : await user_cache.getAppHash(),
      "accessToken" : finalUser.token,
      "accessSecret" : finalUser.secret,
      "page" : page,
      "sdkVersion" : const_util.sdkVersion
    });
    return data;
  }

  @override
  toRefresh() {
    return null;
  }
}