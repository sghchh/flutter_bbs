/// 搜索帖子的时候返回的json封装
class SearchTopicResponse {
  _Head head;
  int page;
  int has_next;
  int total_num;
  int searchid;
  List<_Topic> list;

  SearchTopicResponse.fromJson(Map<String, dynamic> json) :
      this.head = _Head.fromJson(json['head']),
      this.page = json['page'],
      this.has_next = json['has_next'],
      this.total_num = json['total_num'],
      this.searchid = json['searchid'] {
    List<_Topic> result = [];
    if (json['list'] == null){
      json['list'] = result;
      return;
    }
    for (int i = 0; i < json['list'].length; i ++) {
      _Topic _topic = _Topic.fromJson(json['list'][i]);
      result.add(_topic);
    }
    this.list = result;
  }
}
/// 搜索用户的时候返回的json
class SearchUserResponse {
  _Head head;
  _SearchUserBody body;
  int page;
  int has_next;
  int total_num;
  int searchid;

  SearchUserResponse.fromJson(Map<String, dynamic> json) :
      this.head = _Head.fromJson(json['head']),
        this.page = json['page'],
        this.has_next = json['has_next'],
        this.total_num = json['total_num'],
        this.searchid = json['searchid'],
      this.body = _SearchUserBody.fromJson(json['body']);
}

class _SearchUserBody {
  List<_SearchUser> list;

  _SearchUserBody.fromJson(Map<String, dynamic> json) {
    List<_SearchUser> result = [];
    if (json['list'] == null){
      json['list'] = result;
      return;
    }
    for (int i = 0; i < json['list'].length; i ++) {
      _SearchUser user = _SearchUser.fromJson(json['list'][i]);
      result.add(user);
    }
    this.list = result;
  }
}

class _SearchUser {
  int uid;
  String icon;
  int isFriend;
  int gender;
  String name;
  String dateline;
  String signture;

  _SearchUser.fromJson(Map<String, dynamic> json) :
      this.uid = json['uid'],
      this.icon = json['icon'],
      this.isFriend = json['isFriend'],
      this.gender = json['gender'],
      this.name = json['name'],
      this.dateline = json['dateline'],
      this.signture = json['signture'];
}

/// 搜索帖子返回json中帖子的封装
class _Topic {
  int topic_id;           // 表示一个帖子，获取帖子详情的时候需要该参数
  int board_id;
  String title;       // 帖子的标题
  String subject;      // 帖子内容的简介
  String user_nick_name;   // 发帖人的用户名
  String last_reply_date;      // 最后一个回复的时间戳
  int hits;     // 点击量
  int replies;  // 回复数
  int user_id;   // 代表一个用户，获取用户信息的时候需要该参数

  _Topic.fromJson(Map<String, dynamic> json) :
      this.topic_id = json['topic_id'],
      this.board_id = json['board_id'],
      this.title = json['title'],
      this.subject = json['subject'],
      this.user_nick_name = json['user_nick_name'],
      this.user_id = json['user_id'],
      this.last_reply_date = json['last_reply_date'],
      this.hits = json['hits'],
      this.replies = json['replies'];
}

class _Head {
  String errCode;
  String errInfo;

  _Head.fromJson(Map<String, dynamic> json) :
      this.errInfo = json['errInfo'],
      this.errCode = json['errCode'];
}