///created by sgh     2019-3-4
/// 登录后返回的Json封装
class User {
  int rs;
  String errcode;
  _HeadBean head;
  _BodyBean body;
  int isValidation;
  String token;
  String secret;
  int score;
  int uid;
  String userName;
  String avatar;
  int gender;
  String userTitle;
  String mobile;
  int groupid;
  List repeatList;
  List verify;
  List<_CreditShowListBean> creditShowList;


  User({this.rs,
      this.errcode,
      this.head,
      this.body,
      this.isValidation,
      this.token,
      this.secret,
      this.score,
      this.uid,
      this.userName,
      this.avatar,
      this.gender,
      this.userTitle,
      this.mobile,
      this.groupid,
      this.repeatList,
      this.verify,
      this.creditShowList});

  User.fromJson(Map<String, dynamic> json)
      : this.errcode = json['errcode'],
        this.head = json['head'] != null ? _HeadBean.fromJson(json['head']) : null,
        this.body = json['body'] != null ? _BodyBean.fromJson(json['body']) : null,
        this.isValidation = json['isValidation'],
        this.token = json['token'],
        this.secret = json['secret'],
        this.score = json['score'],
        this.uid = json['uid'],
        this.userName = json['userName'],
        this.avatar = json['avatar'],
        this.gender = json['gender'],
        this.userTitle = json['userTitle'],
        this.mobile = json['mobile'],
        this.groupid = json['groupid'],
        this.repeatList = json['repeatList'],
        this.verify = json['verify'] {
    var result = <_CreditShowListBean>[];
    for (int i = 0; i < json['creditShowList'].length; i ++) {
      var item = _CreditShowListBean.fromJson(json['creditShowList'][i]);
      result.add(item);
    }
    this.creditShowList = result;
  }



  Map<String, dynamic> toJson() => {
    'rs' : this.rs,
    'errcode' : this.errcode,
    'head' : this.head.toJson(),
    'body' : this.body.toJson(),
    'isValidation' : this.isValidation,
    'token' : this.token,
    'secret' : this.secret,
    'score' : this.score,
    'uid' : this.uid,
    'userName' : this.userName,
    'avatar' : this.avatar,
    'gender' : this.gender,
    'userTitle' : this.userTitle,
    'mobile' : this.mobile,
    'groupid' : this.groupid,
    'repeatList' : this.repeatList,
    'verify' : this.verify,
    'creditShowList' : this.creditShowList
    //'creditShowList' : (this.creditShowList.length != 0 || this.creditShowList == null) ? this.creditShowList.map((value) => value.toJson()) : []
  };

  @override
  String toString() {
    return "{ \"userName\" : ${userName}, \"avatar\" : ${this.avatar}, \"token\" : ${this.token}, \"secret\" : ${this.token}, \"userTitle\" : ${this.userTitle}, \"uid\" : ${this.uid}, \"creditShowList\" : [{\"type\" : ${this.creditShowList[0].type}, \"title\" : ${this.creditShowList[0].title}, \"data\" : ${this.creditShowList[0].data}}, {\"type\" : ${this.creditShowList[1].type}, \"title\" : ${this.creditShowList[1].title}, \"data\" : ${this.creditShowList[1].data}}]}";
  }
}

///User以及UserList的Bean中的一部分
class _HeadBean {
  String errCode;
  String errInfo;
  String version;
  int alert;

  _HeadBean({this.errCode, this.errInfo, this.version, this.alert});

  _HeadBean.fromJson(Map<String, dynamic> json)
      : this.errCode = json['errCode'],
        this.errInfo = json['errInfo'],
        this.version = json['version'],
        this.alert = json['alert'];

  Map<String, dynamic> toJson() => {
    'errCode' : this.errCode,
    'errInfo' : this.errInfo,
    'version' : this.version,
    'alert' : this.alert
  };
}

///User以及UserList的Bean中的一部分
class _BodyBean {
  _ExternInfoBean externInfo;
  _BodyBean({this.externInfo});
  _BodyBean.fromJson(Map<String, dynamic> map)
      : this.externInfo = _ExternInfoBean.fromJson(map['externInfo']);

  Map<String, dynamic> toJson() => {
    'externInfo' : this.externInfo.toJson()
  };
}

///_BodyBean中的一部分
class _ExternInfoBean {
  String padding;
  _ExternInfoBean({this.padding});
  _ExternInfoBean.fromJson(Map<String, dynamic> json)
      : this.padding = json['padding'];
  Map<String, dynamic> toJson() => {
    'padding' : this.padding
  };
}

///User的Bean中的一部分
class _CreditShowListBean {
  String type;
  String title;
  int data;

  _CreditShowListBean(this.type, this.title, this.data);
  _CreditShowListBean.fromJson(Map<String, dynamic> json)
      : this.type = json['type'],
        this.title = json['title'],
        this.data = json['data'];

  Map<String, dynamic> toJson() => {
    'type' : this.type,
    'title' : this.title,
    'data' : this.data
  };
}

/// 用户信息界面中已经发表帖子的json
class UserPublish {
  String pic_path;
  int board_id;
  String board_name;
  int topic_id;
  int type_id;
  int sort_id;
  String title;
  String subject;
  int user_id;
  String last_reply_date;
  String user_nick_name;
  int hits;
  int replies;
  int top;
  int status;
  int essence;
  int hot;
  String userAvatar;

  UserPublish(this.pic_path, this.board_id, this.board_name, this.topic_id,
      this.type_id, this.sort_id, this.title, this.subject, this.user_id,
      this.last_reply_date, this.user_nick_name, this.hits, this.replies,
      this.top, this.status, this.essence, this.hot, this.userAvatar,);

  UserPublish.fromJson(Map<String, dynamic> json)
      : this.pic_path = json['pic_path'],
        this.board_id = json['board_id'],
        this.board_name = json['board_name'],
        this.topic_id = json['topic_id'],
        this.type_id = json['type_id'],
        this.sort_id = json['sort_id'],
        this.title = json['title'],
        this.subject = json['subject'],
        this.user_id = json['user_id'],
        this.last_reply_date = json['last_reply_date'],
        this.user_nick_name = json['user_nick_name'],
        this.hits = json['hits'],
        this.replies = json['replies'],
        this.top = json['top'],
        this.status = json['status'],
        this.essence = json['essence'],
        this.hot = json['hot'],
        this.userAvatar = json['userAvatar'];
}

/// 用户界面中获取好友列表的json类
class UserList {
  int rs;
  String errcode;
  _HeadBean head;
  _BodyBean body;
  int page;
  int has_next;
  int total_num;
  List<ListBean> list;

  UserList.fromJson(Map<String, dynamic> json)
      : this.rs = json['rs'],
        this.errcode = json['errcode'],
        this.head = _HeadBean.fromJson(json['head']),
        this.body = _BodyBean.fromJson(json['body']),
        this.page = json['page'],
        this.has_next = json['has_next'],
        this.total_num = json['total_num'] {
    var result = <ListBean>[];
    for (int i = 0; i < json['list'].length; i++) {
      var item = ListBean.fromJson(json['list'][i]);
      result.add(item);
    }
    this.list = result;
  }
}

/// UserList的一部分
class ListBean {
  String distance;
  String location;
  int is_friend;
  int isFriend;
  int isFollow;
  int uid;
  String name;
  int status;
  int is_black;
  int gender;
  String icon;
  int level;
  String userTitle;
  String lastLogin;
  String dateline;
  String signature;
  int credits;
  List verify;

  ListBean.fromJson(Map<String, dynamic> json)
      : this.distance = json['distance'],
        this.location = json['location'],
        this.is_friend = json['is_friend'],
        this.isFriend = json['isFriend'],
        this.isFollow = json['isFollow'],
        this.uid = json['uid'],
        this.name = json['name'],
        this.status = json['status'],
        this.is_black = json['is_black'],
        this.gender = json['gender'],
        this.icon = json['icon'],
        this.level = json['level'],
        this.userTitle = json['userTitle'],
        this.lastLogin = json['lastLogin'],
        this.dateline = json['dateline'],
        this.signature = json['signature'],
        this.credits = json['credits'],
        this.verify = json['verify'];
}
