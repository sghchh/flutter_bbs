//{
//	"body": {
//		"json": {
//			"content": "[{\"infor\":\"整天无所事事，开学了没听过课\",\"type\":0}]",
//			"title": "累死了",
//			"fid": 45(该字段代表板块的id),
//			"isAnonymous": 0,
//			"typeId": 394(该字段代表分类的id)
//		}
//	}
//}

/// 发帖时需要post的json
/// 该类位于json的最外层
class PublishJson {
  PublishBody body;
  PublishJson(this.body);
  Map<String, dynamic> toJson() => {
    "body" : this.body.toJson()
  };

  @override
  String toString() {
    return "{\"body\" : ${this.body.toString()}}";
  }
}

/// 该类位于post的json的第二层
class PublishBody {
  PublishInfo json;
  PublishBody(this.json);
  Map<String, dynamic> toJson() => {
    "json" : this.json.toJson()
  };

  @override
  String toString() {
    return "{\"json\":${this.json.toString()}}";
  }
}

/// 该类位于第三层
class PublishInfo {
  String title;
  int fid;      //板块的boardid
  int typeId;      //板块下面分类的id(ClassificationType)
  String content;
  int isAnonymous;

  PublishInfo({this.content, this.typeId, this.fid, this.title, this.isAnonymous : 0});

  Map<String, dynamic> toJson() => {
    "title" : this.title,
    "fid" : this.fid,
    "typeId" : this.typeId,
    "content" : this.content,
    'isAnonymous' : this.isAnonymous
  };

  @override
  String toString() {
    return '{\"title\": "${this.title}", \"fid\" : ${this.fid}, \"typeId\" : ${this.typeId}, \"content\" : ${this.content}, \"isAnonymous\" : ${this.isAnonymous}}';
  }
}

/// 该类组成PublishInfo的content
class PublishContent {
  int type;
  String infor;

  PublishContent(this.type, this.infor);

  @override
  String toString() {
    return '[{\\"infor\\": \\"${this.infor}\\", \\"type\\" : ${this.type}]';
  }
}