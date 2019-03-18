
/// 在获取帖子详情的时候的一部分
/// 作为帖子的所有回复的封装
class ReplyDetail {
  int reply_id;
  List<_ReplyContent> reply_content;
  String reply_name;
  int reply_posts_id;
  String posts_date;
  String icon;
  String mobileSign;
  String quote_content;
  int position;

  ReplyDetail.fromJson(Map<String, dynamic> json)
      : this.reply_id = json['reply_id'],
        this.reply_name = json['reply_name'],
        this.reply_posts_id = json['reply_posts_id'],
        this.posts_date = json['posts_date'],
        this.icon = json['icon'],
        this.mobileSign = json['mobileSign'],
        this.quote_content = json['quote_content'],
        this.position = json['position'] {

    var result = <_ReplyContent>[];
    for (int i = 0; i < json['reply_content'].length; i++) {
      var item = _ReplyContent.fromJson(json['reply_content'][i]);
      result.add(item);
    }
    this.reply_content = result;
  }
}

class _ReplyContent {
  String infor;
  int type;
  String url;

  _ReplyContent.fromJson(Map<String, dynamic> json)
      : this.infor = json['infor'],
        this.type = json['type'],
        this.url = json['url'];
}