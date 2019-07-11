import 'package:flutter/material.dart';
import 'package:flutter_bbs/mvp/model.dart';
import 'package:flutter_bbs/mvp/presenter.dart';
import 'package:flutter_bbs/mvp/view.dart';
import 'package:flutter_bbs/network/json/friend.dart';
import 'package:flutter_bbs/network/json/post.dart';
import 'package:flutter_bbs/network/json/user.dart';
import 'package:flutter_bbs/pages/detail/detail.dart';
import 'package:flutter_bbs/pages/friends/model.dart';
import 'package:flutter_bbs/pages/friends/presenter.dart';
import 'package:flutter_bbs/pages/image_page.dart';
import 'package:flutter_bbs/utils/user_cacahe_util.dart' as user_cache;
import 'package:flutter_bbs/utils/constant.dart' as const_util;
import 'package:flutter_bbs/utils/time_util.dart' as time_util;

class FriendInfoStateful extends StatefulWidget {

  FriendPresenterImpl _presenter;
  FriendModelImpl _model;
  _FriendViewImpl _view;
  int uid;


  FriendInfoStateful({@required this.uid}) : _presenter = FriendPresenterImpl(), _model = FriendModelImpl();
  @override
  State<StatefulWidget> createState() {
    _view = _FriendViewImpl(uid: this.uid);
    _presenter.bindView(_view);
    _presenter.bindModel(_model);
    _view.setPresenter(_presenter);
    return _view;
  }

}

class _FriendViewImpl extends State<FriendInfoStateful> implements IBaseView {

  int uid;

  FriendPresenterImpl _presenterImpl;

  List<Post> data; //展示的数据源

  FriendInforResponse inforResponse;

  String tap; //表示该页代表的内容

  int page = 1; //表示当前数据一共几页

  bool isLoading = false; //表示是否正在加载中

  bool hasMore = false; //表示还有更多数据可供加载

  ScrollController _scrollController;

  var selectedType = 0;      // 标识当前是查看资料还是发帖；0为资料，1为发帖

  _FriendViewImpl({@required this.uid}) {
    _scrollController = ScrollController();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("this is controller:isloading:${isLoading}, hasMore:${hasMore}");
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
    if (inforResponse == null) {
      return FutureBuilder(
        future: toGetNetData(),
        builder: (context, snaphot) {
          //正在进行网络请求
          if (!snaphot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }

          // 该情况代表http错误
          if (snaphot.data.runtimeType == String)
            return Center(child: Text('error'),);

          // 代表没有从服务器获取数据，一般是参数异常导致的
          if ( snaphot.data.head.errCode != const_util.success)
            return Center(child: Text("${snaphot.data.head.errCode} : ${snaphot.data.head.errInfo}"),);

          inforResponse = snaphot.data;
          //hasMore = snaphot.data.has_next == 0 ? false : true;
          return _buildInforArea();
        },
      );
    }
    return _buildInforArea();
  }

  /// 构建界面的方法
  Widget _buildInforArea (){

    List list = [];
    list.addAll(inforResponse.body.profileList);
    //list.addAll(inforResponse.body.creditList);
    //list.addAll(inforResponse.body.creditShowList);
    var map = <String, String>{};
    for (int i = 0; i < list.length; i ++) {
      if (list[i].data.toString() != null && list[i].data.toString() != "")
        map[list[i].title] = list[i].data.toString();
    }
    // 获取手机屏幕的宽高
    num screenHeight = MediaQuery.of(context).size.height;
    num screenWidght = MediaQuery.of(context).size.width;
    // 该好友是否有个性签名，下面会根据该值调整姓名和userTitle的位置
    bool isSigned = !(inforResponse.sign == null || inforResponse.sign == "");
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              children: <Widget>[
                // 构建头像区域的背景图
                GestureDetector(
                  child: Container(
                    width: screenWidght,
                    height: screenHeight * 0.23,
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.transparent, Colors.black26, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      ),
                    ),
                    child: Image.network(inforResponse.icon,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ImagePage(url : inforResponse.icon);
                    }));
                  },
                ),
                // 构建头像区域的信息展示内容
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.23,
                  padding: EdgeInsets.only(left: 10, top: isSigned ? screenHeight * 0.10 : screenHeight * 0.13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(inforResponse.name, textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontSize: 20),),
                      isSigned ? Text(inforResponse.sign, textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis,) : Container(height: 0,),
                      Text(inforResponse.userTitle, textAlign: TextAlign.start, style: TextStyle(color: Colors.white, fontSize: 13),)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FlatButton(
                child: Text("个人资料", style: TextStyle(fontSize: 18)),
                textColor: selectedType == 0 ? Colors.white : Colors.grey,
                color: selectedType == 0 ? Colors.blueAccent : Colors.white,
                onPressed: () {
                  setState(() {
                    selectedType = 0;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                child: Text("个人发帖", style: TextStyle(fontSize: 18),),
                textColor: selectedType == 1 ? Colors.white : Colors.grey,
                color: selectedType == 1 ? Colors.blueAccent : Colors.white,
                onPressed: () {
                  setState(() {
                    selectedType = 1;
                  });
                },
              ),
            ),
          ],
        ),
        // 直接放List不行，那就将List放到Container中
        Expanded(
          child: Container(
            child: selectedType == 0 ? _buildPersionInfo(map) : _buildList(),
          ),
        )
      ],
    );
  }

  /// 如果当前是查看个人信息的界面
  ///  该方法用来构建展示个人信息的区域  
  ///  参数为可以展示的个人信息，key为个人信息的类别，value为对应的值 
  Widget _buildPersionInfo(Map<String, String> informations) {  
      List<String> infors = informations.keys.toList();
      return ListView.builder(
        shrinkWrap: true,
          itemCount: informations.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(width: 0.1, color: Colors.black26), bottom: index == informations.length - 1 ? BorderSide(width: 0.2, color: Colors.black26) : BorderSide(width: 0))),
              padding: EdgeInsets.only(top: 10, bottom: 6, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(infors[index], style: TextStyle(fontSize: 15, color: Colors.black54,), textAlign: TextAlign.start,),
                  ),
                  Text(informations[infors[index]], style: TextStyle(fontSize: 18,), textAlign: TextAlign.start),
                ],
              ),
            );
          }
      );
  }

  Widget _buildList() {
    if (data == null) {
      return FutureBuilder(
        future: toGetNetData(),
        builder: (context, snaphot){
          //正在进行网络请求
          if (!snaphot.hasData) {
            return Center(child: CircularProgressIndicator(),);
          }

          // 该情况代表http错误
          if (snaphot.data.runtimeType == String)
            return Center(child: Text('error'),);

          // 代表没有从服务器获取数据，一般是参数异常导致的
          if ( snaphot.data.head.errCode != const_util.success)
            return Center(child: Text("${snaphot.data.head.errCode} : ${snaphot.data.head.errInfo}"),);

          data = snaphot.data.list;
          hasMore = snaphot.data.has_next == 0 ? false : true;
          return _buildListIfOk();
        },
      );
    }
    return _buildListIfOk();
  }
  /// 构建链表
  Widget _buildListIfOk() {
    _check();
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
                              child: Text(time_util.decodeTime(data[index].last_reply_date),
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

  /// 构建 加载更多提示 的widget
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


  /// 该方法的作用是将List<Post>中属于已经关闭板块的帖子去掉
  _check() {
    for (int i = 0; i < data.length; ) {
      if (const_util.forbiddenBoard[data[i].board_id] == 1) {
        data.removeAt(i);
        continue;
      }
      i++;
    }
  }

  @override
  bindData(sourcedata, type) {
    setState(() {
      if (type == const_util.loadMore && selectedType == 1) {
        page++;
        this.data.addAll(sourcedata.list);
      } else if (type == const_util.refresh && selectedType == 1) {
        this.data = sourcedata.list;
      } else {
        hasMore = false;
      }
      isLoading = false;
    });
  }

  @override
  IBasePresenter<IBaseView, IBaseModel> get presenter => _presenterImpl;

  @override
  void setPresenter(presenter) {
    _presenterImpl = presenter;
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
    presenter.loadMoreNetData(type: const_util.friend_published,query: {
      "uid" : this.uid,
      "appHash" : await user_cache.getAppHash(),
      "accessToken" : finalUser.token,
      "accessSecret" : finalUser.secret,
      "page" : page + 1,
      "pageSize" : 10,
      "sdkVersion" : const_util.sdkVersion,
      "type" : "topic"
    });
  }

  @override
  toGetNetData() async{
    User finalUser = await user_cache.finalUser();
    print(uid);
    if (selectedType == 1) {
      var response = presenter.loadNetData(type: const_util.friend_published,query: {
        "uid" : this.uid,
        "appHash" : await user_cache.getAppHash(),
        "accessToken" : finalUser.token,
        "accessSecret" : finalUser.secret,
        "page" : 1,
        "pageSize" : 10,
        "sdkVersion" : const_util.sdkVersion,
        "type" : "topic"
      });
      return response;
    }
    var response = presenter.loadNetData(type: const_util.friend_infor,query: {
    "userId" : this.uid,
    "appHash" : await user_cache.getAppHash(),
    "accessToken" : finalUser.token,
    "accessSecret" : finalUser.secret,
    "sdkVersion" : const_util.sdkVersion
    });
    return response;
  }

  @override
  Future<void> toRefresh() async{
    User finalUser = await user_cache.finalUser();
    await presenter.loadMoreNetData(type: const_util.friend_published,query: {
    "uid" : this.uid,
    "appHash" : await user_cache.getAppHash(),
    "accessToken" : finalUser.token,
    "accessSecret" : finalUser.secret,
    "page" : 1,
    "pageSize" : 10 * page,
    "sdkVersion" : const_util.sdkVersion,
    "type" : "topic"
    });
  }
}