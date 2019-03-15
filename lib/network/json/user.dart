/**
 * created by sgh     2019-3-4
 * 登录后返回的Json封装
 */
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
    return "{ \"userName\" : ${userName}, \"avatar\" : ${this.avatar}, \"token\" : ${this.token}, \"secret\" : ${this.token}, \"userTitle\" : ${this.userTitle}}";
  }
}

/**
 * User的Bean中的一部分
 */
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

/**
 * User的Bean中的一部分
 */
class _BodyBean {
  _ExternInfoBean externInfo;
  _BodyBean({this.externInfo});
  _BodyBean.fromJson(Map<String, dynamic> map)
      : this.externInfo = _ExternInfoBean.fromJson(map['externInfo']);

  Map<String, dynamic> toJson() => {
    'externInfo' : this.externInfo.toJson()
  };
}

/**
 * _BodyBean中的一部分
 */
class _ExternInfoBean {
  String padding;
  _ExternInfoBean({this.padding});
  _ExternInfoBean.fromJson(Map<String, dynamic> json)
      : this.padding = json['padding'];
  Map<String, dynamic> toJson() => {
    'padding' : this.padding
  };
}

/**
 * User的Bean中的一部分
 */
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
