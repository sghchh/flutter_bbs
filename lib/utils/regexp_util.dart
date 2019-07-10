import 'dart:io';

// 通过正则表达式获取发帖信息中的表情包和文字
List<RegExpType> getContentDetail(String source) {
  String str = r"\[mobcent_phiz=[^\]]*\]";
  RegExp reg = RegExp(str);
  Iterable<Match> matchs = reg.allMatches(source);

  // 如果没有匹配到，直接返回
  if (matchs.length == 0) {
    return [RegExpType(source, content_text)];
  }
  var result = <int>[];
  for (int i = 0; i < matchs.length; i++) {
    // result列表中封装了所有url的位置信息
    Match m = matchs.elementAt(i);
    result.add(m.start);
    result.add(m.end);
  }

  List<RegExpType> list = <RegExpType>[];
  for (int i = 0; i < result.length - 1; i += 2) {
    String str1;
    if (i == 0 ){
      str1 = source.substring(0, result[i]);
    } else {
      str1 = source.substring(result[i - 1], result[i]);
    }
    // 将中括号和前面的冗余去掉
    String str2 = source.substring(result[i] + 14, result[i + 1] - 1);
    list.add(RegExpType(str1, content_text));
    list.add(RegExpType(str2, content_url));
  }
  return list;
}

Iterable<Match> getAllEmojis(String source) {
  String str = r"\[s:\d+\]";
  RegExp reg = RegExp(str);
  return reg.allMatches(source);
}

/// 用于标注正则表达式结果中的是文字内容还是url
///  type 取值为content_url 或者content_text
class RegExpType {
  String type;
  String content;
  RegExpType(this.content, this.type);
}

const String content_url = "url";
const String content_text = 'text';