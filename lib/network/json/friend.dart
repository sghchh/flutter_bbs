/// 获取好友信息返回的最终JSON
class FriendInforResponse {
  _Head head;
  _Body body;
  int isFriend;        // 表示是否是好友关系，1为是
  String icon;       // 头像的URL
  String name;
  String email;
  String sign;
  String userTitle;
  String mobile;

  FriendInforResponse({this.body, this.email, this.head, this.icon, this.isFriend, this.mobile, this.name, this.sign, this.userTitle});

  FriendInforResponse.fromJson(Map<String, dynamic> json) :
      this.userTitle = json['userTitle'],
      this.sign = json['sign'],
      this.name = json['name'],
      this.mobile = json['mobile'],
      this.isFriend = json['isFriend'],
      this.icon = json['icon'],
      this.head = _Head.fromJson(json['head']),
      this.email = json['email'],
      this.body = _Body.fromJson(json['body']);
}

/// 封装请求状态的JSON
class _Head {
  String errCode;     // 状态码
  String errInfo;     // 错误描述

  _Head({this.errCode, this.errInfo});

  _Head.fromJson(Map<String, dynamic> json) :
      this.errInfo = json['errInfo'],
      this.errCode = json['errCode'];
}

/// 只是做一层包装
class _Body {
  List<_Infor> profileList;
  List<_Infor> creditList;
  List<_Infor> creditShowList;

  _Body({this.profileList, this.creditList, this.creditShowList});
  _Body.fromJson(Map<String, dynamic> json) {
    var result = <_Infor>[];
    for(int i = 0; i < json['profileList'].length; i++) {
      var item = _Infor.fromJson(json['profileList'][i]);
      result.add(item);
    }
    this.profileList = result;

    result = <_Infor>[];
    for(int i = 0; i < json['creditList'].length; i++) {
      var item = _Infor.fromJson(json['creditList'][i]);
      result.add(item);
    }
    this.creditList = result;

    result = <_Infor>[];
    for(int i = 0; i < json['creditShowList'].length; i++) {
      var item = _Infor.fromJson(json['creditShowList'][i]);
      result.add(item);
    }
    this.creditShowList = result;
  }
}

/// 封装 各种信息 的JSON
class _Infor {
  String type;    // 代表信息类别；如：性别等
  String title;   // 信息类别的中文描述，如：性别
  String data;      // 信息的值

  _Infor({this.type, this.data, this.title});

  _Infor.fromJson(Map<String, dynamic> json) :
      this.title = json['title'],
      this.data = json['data'].toString(),
      this.type = json['type'];
}


