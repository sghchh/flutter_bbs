import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/search.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/detail/detail.dart';
import 'package:flutter_bbs/pages/friends/friends_info.dart';
import 'package:flutter_bbs/pages/search/model.dart';
import 'package:flutter_bbs/pages/search/presenter.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/utils/time_util.dart' as time_util;

class SearchWidget extends StatefulWidget {
  SearchPresenterImpl _presenter;
  SearchModelImpl _model;
  _SearchViewImpl _view;
  @override
  State<StatefulWidget> createState() {
    this._view = _SearchViewImpl();
    this._presenter = SearchPresenterImpl();
    this._model = SearchModelImpl();
    _presenter.bindModel(_model);
    _presenter.bindView(_view);
    _view.setPresenter(_presenter);
    return _view;
  }
}

class _SearchViewImpl extends State<SearchWidget> with TickerProviderStateMixin implements IBaseView {

  TextEditingController _textEditingController;

  TabController _controller; // TabBar的controller

  SearchPresenterImpl _presenter;

  SearchTopicResponse _topicResponse; // 搜索帖子返回的Response

  SearchUserResponse _userResponse; // 搜索用户返回的Response

  bool _isLoading = false; //表示是否正在加载中

  bool _topicHasMore = false; //表示还有更多数据可供加载

  bool _userHasMore = false; //表示还有更多数据可供加载

  ScrollController _topicController;

  ScrollController _userController;

  var selectedType = 0; // 标识当前；0为帖子，1为用户
  int _topicPage = 1;
  int _userPage = 1;

  String keyword;

  _SearchViewImpl() {
    _textEditingController = TextEditingController();
    _controller = TabController(length: 2, vsync: this);
    _topicController = ScrollController();
    _userController = ScrollController();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        selectedType = _controller.previousIndex == 0 ? 1 : 0;
      });
      print(selectedType);
    });

    _topicController.addListener(() {
      if (_topicController.position.pixels ==
          _topicController.position.maxScrollExtent) {
        if (!_isLoading && _topicHasMore) {
          toGetMoreNetData();
          setState(() {
            _isLoading = true;
          });
        }
      }
    });

    _userController.addListener(() {
      if (_userController.position.pixels ==
          _userController.position.maxScrollExtent) {
        if (!_isLoading && _userHasMore) {
          toGetMoreNetData();
          setState(() {
            _isLoading = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '清水河畔',
      home: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Colors.blue,
              leading: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    toGetNetData();
                  }),
              title: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                    hintText: '输入关键字',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18)
                ),
                cursorColor: Colors.white,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              ),
              centerTitle: true,
              bottom: TabBar(
                  controller: _controller,
                  labelPadding: EdgeInsets.all(5),
                  tabs: [
                    Text("帖子", style: TextStyle(fontSize: 15)),
                    Text("用户", style: TextStyle(fontSize: 15)),
                  ]),
            ),
            preferredSize: Size.fromHeight(65)
        ),
        body: selectedType == 0 ? _buildTopicWidget() : _buildUserWidget()
      ),
    );
  }

  /// 该方法是用来构建 帖子 返回的界面
  Widget _buildTopicWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: _topicResponse == null ? Container() : _buildTopicList(),
    );
  }

    /// 该方法是用来构建 用户 返回的界面
    Widget _buildUserWidget() {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: _userResponse == null ? Container() : _buildUserList(),
      );
    }

    /// 构建返回 帖子  的列表
    Widget _buildTopicList() {
      _check();
      return RefreshIndicator(
        onRefresh: toRefresh,
        child: ListView.builder(
          controller: _topicController,
          itemBuilder: (context, index) {
            if (index < _topicResponse.list.length) {
              return GestureDetector(
                onTap: () {
                  var post = _topicResponse.list[index];
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //注意今日热点的topicId等同于其source_id
                    return DetailPageWidget(
                        _topicResponse.list[index].topic_id);
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 6, bottom: 6, left: 10, right: 8),
                  margin:
                  const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('${_topicResponse.list[index]
                                    .user_nick_name}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey)),
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(time_util.decodeTime(
                                    _topicResponse.list[index].last_reply_date),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey))),
                            Container(
                                padding: EdgeInsets.only(top: 4, bottom: 4),
                                child: Text(
                                  '${_topicResponse.list[index].title}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                Container(
                                  margin:
                                  const EdgeInsets.only(left: 6, right: 6),
                                  child: Text(
                                      '${_topicResponse.list[index].hits}',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ),
                                Icon(
                                  Icons.chat_bubble_outline,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  child: Text(
                                      '${_topicResponse.list[index].replies}',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return _buildLoadMore();
            }
          },
          itemCount: _topicResponse.list.length + 1,
        ),
      );
    }

    /// 构建返回 用户 的列表
    Widget _buildUserList() {
      return RefreshIndicator(
        onRefresh: toRefresh,
        child: ListView.builder(
          controller: _userController,
          padding: EdgeInsets.all(2),
          itemCount: _userResponse.body.list.length + 1,
          itemBuilder: (context, index) {
            if (index == _userResponse.body.list.length)
              return _buildLoadMore();
            return ListTile(
              leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(
                  _userResponse.body.list[index].icon), radius: 24,),
              title: Text(_userResponse.body.list[index].name,
                  style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //注意今日热点的topicId等同于其source_id
                  return FriendInfoWidget(
                      uid: _userResponse.body.list[index].uid);
                }));
              }, // 需要跳转到好友信息界面
            );
          },
        ),
      );
    }

    /// 构建 加载更多提示 的widget
    Widget _buildLoadMore() {
      if (_isLoading) {
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
      if (selectedType == 0 ? !_topicHasMore : !_userHasMore) {
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


    /// 该方法的作用是将List<Post>中属于已经关闭板块的帖子去掉
    _check() {
      for (int i = 0; i < _topicResponse.list.length;) {
        if (const_util.forbiddenBoard[_topicResponse.list[i].board_id] == 1) {
          _topicResponse.list.removeAt(i);
          continue;
        }
        i++;
      }
    }

    @override
    bindData(sourcedata, type) {
      setState(() {
        if (selectedType == 0) {
          if (type == const_util.loadMore) {
            _topicPage++;
            this._topicResponse.list.addAll(sourcedata.list);
          } else if (type == const_util.refresh) {
            this._topicResponse.list = sourcedata.list;
          } else if (type == const_util.noMore){
            _topicHasMore = false;
          } else {
            _topicResponse = sourcedata;
            _topicHasMore = _topicResponse.has_next == 1 ? true : false;
          }

        } else {
          if (type == const_util.loadMore) {
            _userPage++;
            this._userResponse.body.list.addAll(sourcedata.body.list);
          } else if (type == const_util.refresh) {
            this._userResponse.body.list = sourcedata.body.list;
          } else if (type == const_util.noMore){
            _userHasMore = false;
          } else {
            _userResponse = sourcedata;
            _userHasMore = _userResponse.has_next == 1 ? true : false;
          }

        }
        _isLoading = false;
      });
    }

    @override
    IBasePresenter<IBaseView, IBaseModel> get presenter =>
    _presenter;

    @override
    void setPresenter(presenter) {
      this._presenter = presenter;
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
    toGetMoreNetData() async {
      User finalUser = await user_cache.finalUser();
      presenter.loadMoreNetData(
          type: selectedType == 0 ? const_util.search_topic : const_util
              .search_user,
          query: {
            "searchid": 0,
            "appHash": await user_cache.getAppHash(),
            "accessToken": finalUser.token,
            "accessSecret": finalUser.secret,
            "page": selectedType == 0 ? _topicPage + 1 : _userPage + 1,
            "pageSize": 10,
            "sdkVersion": const_util.sdkVersion,
            "keyword": _textEditingController.text
          });
    }

    @override
    Future toGetNetData() async {
      User finalUser = await user_cache.finalUser();
      var response = presenter.loadNetData(
          type: selectedType == 0 ? const_util.search_topic : const_util
              .search_user,
          query: {
            "searchid": 0,
            "appHash": await user_cache.getAppHash(),
            "accessToken": finalUser.token,
            "accessSecret": finalUser.secret,
            "page": 1,
            "pageSize": 10,
            "sdkVersion": const_util.sdkVersion,
            "keyword": _textEditingController.text
          });
      return response;
    }

    @override
    Future<void> toRefresh() async {
      User finalUser = await user_cache.finalUser();
      await presenter.loadMoreNetData(
          type: selectedType == 0 ? const_util.search_topic : const_util
              .search_user,
          query: {
            "searchid": 0,
            "appHash": await user_cache.getAppHash(),
            "accessToken": finalUser.token,
            "accessSecret": finalUser.secret,
            "page": 1,
            "pageSize": selectedType == 0 ? 10 * _topicPage : 10 * _userPage,
            "sdkVersion": const_util.sdkVersion,
            "keyword": _textEditingController.text
          });
    }

}