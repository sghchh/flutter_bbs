import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/post.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/detail/detail.dart';
import 'package:flutter_bbs/pages/home/model.dart';
import 'package:flutter_bbs/pages/home/presenter.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;
import 'package:flutter_bbs/utils/constant.dart' as const_util;

import 'package:flutter/material.dart';

///created by sgh    2019-02-28
///Home中显示List的StatefulWidget
class HomeWidget extends StatefulWidget {
  HomePresenterImpl _presenter; //创建——HomeState时传递的Presenter对象
  HomeModelImpl _model;
  _HomeViewImpl _view;
  //表示该HomeWidget显示的List的内容，tap值为"最新回复""最新发表""今日热门"三者之一;
  String tap = '最新回复';

  HomeWidget({@required this.tap}) {
    this._presenter = HomePresenterImpl();
    this._model = HomeModelImpl();
  }

  @override
  State<StatefulWidget> createState() {
    this._view = _HomeViewImpl(tap);
    _presenter.bindModel(_model);
    _presenter.bindView(_view);
    _view.setPresenter(_presenter);
    return _view;
  }
}

///HomeState为View层的实现类
class _HomeViewImpl extends State<HomeWidget>
    with AutomaticKeepAliveClientMixin
    implements IBaseView {
  IBasePresenter _presenter; //用啦发起网络请求的Presenter

  List<Post> data; //展示的数据源

  String tap; //表示该页代表的内容

  int page = 1; //表示当前数据一共几页

  bool isLoading = false; //表示是否正在加载中

  bool hasMore = true; //表示还有更多数据可供加载

  ScrollController _scrollController;

  _HomeViewImpl(String tap) {
    this.tap = tap;
    _scrollController = ScrollController();
  }

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
    if (data == null) {
      return _initBuild();
    }
    return _buildList();
  }

  //初始化的时候需要FutureBuilder加载
  Widget _initBuild() {
    return FutureBuilder(
      future: toGetNetData(),
      builder: (context, snaphot) {
        //网络访问中
        if (!snaphot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //网络出错
        if (snaphot.data.runtimeType == String) {
          return Center(child: Text('error'),);
        }

        // 代表没有从服务器获取数据，一般是参数异常导致的
        if ( snaphot.data.head.errCode != const_util.success)
          return Center(child: Text("${snaphot.data.head.errCode} : ${snaphot.data.head.errInfo}"),);

        data = snaphot.data.list;
        hasMore = snaphot.data.has_next == 0 ? false : true;
        return _buildList();
      },
    );
  }

  //构建链表
  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: toRefresh,
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (index < data.length) {
            return GestureDetector(
              onTap: () {
                var post = data[index];
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //注意今日热点的topicId等同于其source_id
                  return DetailPageWidget(this.tap == const_util.TODATHOT
                      ? post.source_id
                      : post.topic_id);
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
                    Container(
                      margin: const EdgeInsets.only(top: 10, right: 10),
                      child: CircleAvatar(
                        backgroundImage:
                        NetworkImage(data[index].userAvatar),
                        radius: 30,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('${data[index].user_nick_name}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey)),
                              Text(
                                '${data[index].board_name}',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 2),
                              child: Text('${data[index].last_reply_date}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey))),
                          Container(
                              padding: EdgeInsets.only(top: 4, bottom: 4),
                              child: Text(
                                '${data[index].title}',
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
                                child: Text('${data[index].hits}',
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
                                child: Text('${data[index].replies}',
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
        itemCount: data.length + 1,
      ),
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
  IBasePresenter<IBaseView, IBaseModel> get presenter => _presenter;

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
    presenter.loadMoreNetData(type: tap, query: {
      'page': page + 1,
      'apphash': await user_cache.getAppHash(),
      'accessSecret': finalUser.secret,
      'accessToken': finalUser.token
    });
  }

  @override
  Future toGetNetData() async {
    User finalUser = await user_cache.finalUser();
    return presenter.loadNetData(type: tap, query: {
      'page': page,
      'apphash': await user_cache.getAppHash(),
      'accessSecret': finalUser.secret,
      'accessToken': finalUser.token
    });
  }

  //和toGetNetData的区别就是没有返回值，而是通过bindData方法更新数据
  @override
  Future<void> toRefresh() async {
    User finalUser = await user_cache.finalUser();
    await presenter.refresh(type: tap, query: {
      'page': 1,
      'apphash': await user_cache.getAppHash(),
      'accessSecret': finalUser.secret,
      'accessToken': finalUser.token
    });
  }

  @override
  bindData(sourcedata, type) {
    setState(() {
      if (type == const_util.loadMore) {
        page++;
        this.data.addAll(sourcedata.list);
      } else if (type == const_util.refresh) {
        page = 1;
        this.data = sourcedata.list;
      }
      hasMore = sourcedata.has_next == 0 ? false : true;
      isLoading = false;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
