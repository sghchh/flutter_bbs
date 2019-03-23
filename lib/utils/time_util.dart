/// 将时间解析出来
String decodeTime(String time) {
  DateTime now = DateTime.now();
  DateTime ti = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  Duration duration = now.difference(ti);
  var days = duration.inDays;
  var hours = duration.inHours;
  var minutes = duration.inMinutes;
  if (minutes < 5)
    return '刚刚';
  if (minutes > 5 && minutes < 60)
    return '${minutes}分钟前';
  if (hours < 24) {
    return '${hours}小时前';
  }
  if (days <= 5)
    return '${days}天前';
  return '${ti.year}-${ti.month}-${ti.day}';
}