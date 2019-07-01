///created by sgh     2019-3-12
/// 该dart文件是一系列"消息"界面的请求json

//根json,这里只是给了个样板，并没有用
class MessageResponse {
  int rs;
  _Head head;
  var body;

}

//组成MessageResponse的元素
class _Head {
  String errInfo;
  String errCode;
  _Head({this.errInfo, this.errCode});

  _Head.fromJson(Map<String, dynamic> json)
      : this.errInfo = json['errInfo'],
        this.errCode = json['errCode'];

}

/// 消息界面中“帖子回复”的json
/// 实际是在MessageResponse的里面
class PostMessage {
  String board_name;    // 所属板块的名字，如水手之家
  int board_id;          // 所属板块的id
  int topic_id;      // 标识该帖子的id，查看详情的时候需要传递该参数
  String topic_subject;  // 帖子的标题
  String topic_content;   // 你在该帖子中发表的某一条评论
  String reply_content;   // 某人根据你的topic_content评论做出的回复内容
  String content;         // 如果是管理员删除你的帖子或者评论，该content会告诉你，这时候content代替reply_content
  String user_name;       // 回复者的用户名
  String icon;          // 回复者的头像URL
  String replied_date;    // 回复的时间


  PostMessage(this.board_name, this.board_id, this.topic_id, this.topic_subject,
      this.topic_content, this.reply_content, this.content, this.user_name,
      this.icon, this.replied_date);

  PostMessage.fromJson(Map<String, dynamic> json)
        : this.board_name = json['board_name'],
          this.board_id = json['board_id'],
          this.topic_id = json['topic_id'],
          this.topic_subject = json['topic_subject'],
          this.topic_content = json['topic_content'],
          this.reply_content = json['reply_content'],
          this.content = json['content'],
          this.user_name = json['user_name'],
          this.icon = json['icon'],
          this.replied_date = json['replied_date'];
}

//消息界面中@我的json
//实际也是嵌在MessageResponse中的
class AtMe {
  String board_name;
  int board_id;
  int topic_id;
  String topic_subject;
  String topic_content;
  String topic_url;
  String reply_content;
  String reply_remind_id;
  String reply_url;
  String user_name;
  int user_id;
  String icon;
  String type;
  String replied_date;
  int isread;

  AtMe(this.board_name, this.board_id, this.topic_id, this.topic_subject,
      this.topic_content, this.topic_url, this.reply_content,
      this.reply_remind_id, this.reply_url, this.user_name, this.user_id,
      this.icon, this.type, this.replied_date, this.isread);

  AtMe.fromJson(Map<String, dynamic> json)
    : this.board_name = json['board_name'],
        this.board_id = json['board_id'],
        this.topic_id = json['topic_id'],
        this.topic_subject = json['topic_subject'],
        this.topic_content = json['topic_content'],
        this.topic_url = json['topic_url'],
        this.reply_content = json['reply_content'],
        this.reply_remind_id = json['reply_remind_id'],
        this.reply_url = json['reply_url'],
        this.user_name = json['user_name'],
        this.user_id = json['user_id'],
        this.icon = json['icon'],
        this.type = json['type'],
        this.replied_date = json['replied_date'],
        this.isread = json['isread'];
}

//消息界面中的“系统消息”的json
//也是嵌在MessageResponse中的
class System {
  String replied_date;
  String icon;
  String user_name;
  String note;

  System(this.replied_date, this.icon, this.user_name, this.note);

  System.fromJson(Map<String, dynamic> json)
      : this.replied_date = json['replied_date'],
        this.icon = json['icon'],
        this.user_name = json['user_name'],
        this.note = json['note'];
}

/// 代表一条 私信
class PmseMission {
  int plid;
  int pmid;
  int lastUserId;
  String lastUserName;
  String lastSummary;
  String lastDateline;
  int toUserId;
  String toUserAvatar;
  String toUserName;
  int toUserIsBlack;
  int isNew;

  PmseMission(this.plid, this.pmid, this.lastUserId, this.lastUserName,
      this.lastSummary, this.lastDateline, this.toUserId, this.toUserAvatar,
      this.toUserName, this.toUserIsBlack, this.isNew);

  PmseMission.fromJson(Map<String, dynamic> json)
      : this.plid = json['plid'],
        this.pmid = json['pmid'],
        this.lastUserId = json['lastUserId'],
        this.lastUserName = json['lastUserName'],
        this.lastSummary = json['lastSummary'],
        this.lastDateline = json['lastDateline'],
        this.toUserId = json['toUserId'],
        this.toUserAvatar = json['toUserAvatar'],
        this.toUserIsBlack = json['toUserIsBlack'],
        this.toUserName = json['toUserName'],
        this.isNew = json['isNew'];
}

/// 消息界面中 私信 的最终返回的json
class MsgRespListPmse {
  int rs;
  _Head head;
  _PmseBody body;

  MsgRespListPmse({this.rs, this.head, this.body});

  MsgRespListPmse.fromJson(Map<String, dynamic> json)
      : this.rs = json['rs'],
        this.head = _Head.fromJson(json['head']),
        this.body = _PmseBody.fromJson(json['body']);
}

/// 搭配MsgRespListPmse
class _PmseBody {
  List<PmseMission> list;

  _PmseBody({this.list});

  _PmseBody.fromJson(Map<String, dynamic> json) {
    var result = <PmseMission>[];
    for(int i = 0; i < json['list'].length; i++) {
      var item = PmseMission.fromJson(json['list'][i]);
      result.add(item);
    }
    this.list = result;
  }
}

/// 消息界面中 系统消息 的最终返回的json
class MsgRespListSystem {
  int rs;
  _Head head;
  _SystemBody body;

  MsgRespListSystem({this.rs, this.head, this.body});

  MsgRespListSystem.fromJson(Map<String, dynamic> json)
      : this.rs = json['rs'],
        this.head = _Head.fromJson(json['head']),
        this.body = _SystemBody.fromJson(json['body']);
}

/// 搭配MsgRespListSystem
class _SystemBody {
  List<System> data;

  _SystemBody({this.data});

  _SystemBody.fromJson(Map<String, dynamic> json) {
    var result = <System>[];
    for(int i = 0; i < json['data'].length; i++) {
      var item = System.fromJson(json['data'][i]);
      result.add(item);
    }
    this.data = result;
  }
}

/// 消息界面中 帖子回复 的最终返回的json
class MsgRespListReply {
  int rs;
  _Head head;
  _ReplyBody body;

  MsgRespListReply({this.rs, this.head, this.body});

  MsgRespListReply.fromJson(Map<String, dynamic> json)
      : this.rs = json['rs'],
        this.head = _Head.fromJson(json['head']),
        this.body = _ReplyBody.fromJson(json['body']);
}

/// 搭配MsgRespListReply
/// 封装了所有 帖子回复 中的消息
class _ReplyBody {
  List<PostMessage> data;

  _ReplyBody({this.data});

  _ReplyBody.fromJson(Map<String, dynamic> json) {
    var result = <PostMessage>[];
    for(int i = 0; i < json['data'].length; i++) {
      var item = PostMessage.fromJson(json['data'][i]);
      result.add(item);
    }
    this.data = result;
  }
}

/// 消息界面中 @我 的最终返回的json
class MsgRespListAtMe {
  int rs;
  _Head head;
  _AtMeBody body;

  MsgRespListAtMe({this.rs, this.head, this.body});

  MsgRespListAtMe.fromJson(Map<String, dynamic> json)
      : this.rs = json['rs'],
        this.head = _Head.fromJson(json['head']),
        this.body = _AtMeBody.fromJson(json['body']);
}

/// 搭配MsgRespListAtMe
class _AtMeBody {
  List<AtMe> data;

  _AtMeBody({this.data});

  _AtMeBody.fromJson(Map<String, dynamic> json) {
    var result = <AtMe>[];
    for(int i = 0; i < json['data'].length; i++) {
      var item = AtMe.fromJson(json['data'][i]);
      result.add(item);
    }
    this.data = result;
  }
}
