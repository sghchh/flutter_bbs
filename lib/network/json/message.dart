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

//消息界面中“帖子回复”的json
//实际是在MessageResponse的里面
class PostMessage {
  String board_name;
  int board_id;
  int topic_id;
  String topic_subject;
  String topic_content;
  String topic_url;
  String reply_content;
  int reply_remind_id;
  String reply_url;
  String content;
  String user_name;
  int user_id;
  String icon;
  String type;
  String replied_date;
  int is_read;
  String mod;


  PostMessage(this.board_name, this.board_id, this.topic_id, this.topic_subject,
      this.topic_content, this.topic_url, this.reply_content,
      this.reply_remind_id, this.reply_url, this.content, this.user_name,
      this.user_id, this.icon, this.type, this.replied_date, this.is_read,
      this.mod);

  PostMessage.fromJson(Map<String, dynamic> json)
        : this.board_name = json['board_name'],
          this.board_id = json['board_id'],
          this.topic_id = json['topic_id'],
          this.topic_subject = json['topic_subject'],
          this.topic_content = json['topic_content'],
          this.topic_url = json['topic_url'],
          this.reply_content = json['reply_content'],
          this.reply_remind_id = json['reply_remind_id'],
          this.reply_url = json['reply_url'],
          this.content = json['content'],
          this.user_name = json['user_name'],
          this.user_id = json['user_id'],
          this.icon = json['icon'],
          this.type = json['type'],
          this.replied_date = json['replied_date'],
          this.is_read = json['is_read'],
          this.mod = json['mod'];
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
  String type;
  String icon;
  String user_name;
  String user_id;
  String mod;
  String note;
  String is_read;

  System(this.replied_date, this.type, this.icon, this.user_name, this.user_id,
      this.mod, this.note, this.is_read);

  System.fromJson(Map<String, dynamic> json)
      : this.replied_date = json['replied_date'],
        this.type = json['type'],
        this.icon = json['icon'],
        this.user_name = json['user_name'],
        this.user_id = json['user_id'],
        this.mod = json['mod'],
        this.note = json['note'],
        this.is_read = json['is_read'];
}

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

//消息界面中 私信 的最终返回的json
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

//搭配MsgRespListPmse
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

//消息界面中 系统消息 的最终返回的json
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

//搭配MsgRespListSystem
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

//消息界面中 帖子回复 的最终返回的json
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

//搭配MsgRespListReply
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

//消息界面中 @我 的最终返回的json
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

//搭配MsgRespListAtMe
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
