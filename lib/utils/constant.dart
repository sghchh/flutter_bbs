
const String BOARD = 'board';
const String TODATHOT = '今日热点';    //home界面的今日热点
const String NEWREPLY = '最新回复';    //home界面的最新回复
const String NEWPUBLISH = '最新发表';   //home界面的最新发表
const String MESSAGE_REPLY = 'message_reply';   //消息界面的回复
const String MESSAGE_ATME = 'message_atme';     //消息界面的@我
const String MESSAGE_SYSTEM = 'message_system';   //消息界面的系统消息
const String MESSAGE_PMSE = 'message_pmse';    //消息界面的私信

const String user_publish = 'user_publish';       //用来区分User界面中当前的请求是：已发表
const String userPublishType = 'topic';            //用户界面中获取已经发表消息时必须传递的type参数的值
const String user_favourite = 'user_favourite';     //用来区分User界面中当前的请求是：我的收藏
const String userFavoriteType = 'favorite';        //用户界面中获取我的收藏时必须传递的type参数的值
const String user_friends = 'user_friends';           //用来区分User界面中当前的请求是：好友列表
const String userFriendsType = 'friend';          //用户界面中获取好友列表时必须传递的type参数的值

const String board_boardList = 'boardList';    //板块界面获取板块列表
const String board_childBoard = 'childBoard';        //板块界面获取子板块

const String sdkVersion = "2.6.1.7";
const String refresh = 'refresh';                  //表示该网络请求是刷新
const String loadMore = 'loadMore';              //表示该网络请求是加载更多数据
const String noMore = 'noMore';                  //表示加载数据时没有更多数据了
const String success = '00000000';         //代表成功获取服务器的数据