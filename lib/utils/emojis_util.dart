import 'dart:convert' as convert;

import 'package:flutter_bbs/pages/edit/comment/comment.dart';
/// 该dart文件用来处理表情包

/// 将dataJson转化为Emojis对象
void init() {
  emojis = _Emojis.fromJson(convert.jsonDecode(dataJson));
}

const comment = 0;
const publish = 1;
int type;       // 表示当前需要操作表情的是评论界面还是发表界面：值为0或1
_Emojis emojis;
/// baseURL连同_Data中的src拼接成表情包的完整URL
String baseURL = "http://bbs.uestc.edu.cn/static/image/smiley/";
CommentState commentState;

// 用来调用添加表情操作
appendEmojis(EmojisIndex e) {
  switch(type) {
    case comment:
      commentState.appendEmojis(e);
      break;
    case publish:
      break;
  }
}

class EmojisIndex {
  int start; // 该表情包的alt值在文本中的起始位置
  int end;   // 该表情包的alt值在文本中的最后位置
  String url;  // 该表情包的封装后的url
  String alt;
}

/// 表情包的Json封装
class _Emojis {
  List<_Tag> emojis;
  _Emojis.fromJson(Map<String, dynamic> json) {
    List<_Tag> result = [];
    for (int i = 0; i < json['emojis'].length; i ++)  {
      var data = _Tag.fromJson(json['emojis'][i]);
      result.add(data);
    }
    this.emojis = result;
  }
}

class _Tag {
  String tag;
  List<_Data> list;

  _Tag.fromJson(Map<String, dynamic> json) :
        this.tag = json['tag'] {
    List<_Data> result = [];
    for (int i = 0; i < json['list'].length; i ++)  {
      var data = _Data.fromJson(json['list'][i]);
      result.add(data);
    }
    this.list = result;
  }
}

class _Data {
  String src;
  String alt;

  _Data.fromJson(Map<String, dynamic> json) :
        this.src = json['src'],
        this.alt = json['alt'];
}
/// 该多行字符串是所有表情链接的Json
const dataJson = '''{
                "emojis":[
                    {
                        "tag": "mushroom",
                        "list":
                            [{"src":"mushroom/076.gif" ,"alt":"[s:285]"},
                            {"src":"mushroom/056.gif" ,"alt":"[s:265]"},
                            {"src":"mushroom/055.gif" ,"alt":"[s:264]"},
                            {"src":"mushroom/054.gif" ,"alt":"[s:263]"},
                            {"src":"mushroom/053.gif" ,"alt":"[s:262]"},
                            {"src":"mushroom/052.gif" ,"alt":"[s:261]"},
                            {"src":"mushroom/051.gif" ,"alt":"[s:260]"},
                            {"src":"mushroom/050.gif" ,"alt":"[s:259]"},
                            {"src":"mushroom/049.gif" ,"alt":"[s:258]"},
                            {"src":"mushroom/048.gif" ,"alt":"[s:257]"},
                            {"src":"mushroom/047.gif" ,"alt":"[s:256]"},
                            {"src":"mushroom/046.gif" ,"alt":"[s:255]"},
                            {"src":"mushroom/045.gif" ,"alt":"[s:254]"},
                            {"src":"mushroom/044.gif" ,"alt":"[s:253]"},
                            {"src":"mushroom/043.gif" ,"alt":"[s:252]"},
                            {"src":"mushroom/042.gif" ,"alt":"[s:251]"},
                            {"src":"mushroom/041.gif" ,"alt":"[s:250]"},
                            {"src":"mushroom/040.gif" ,"alt":"[s:249]"},
                            {"src":"mushroom/057.gif" ,"alt":"[s:266]"},
                            {"src":"mushroom/058.gif" ,"alt":"[s:267]"},
                            {"src":"mushroom/075.gif" ,"alt":"[s:284]"},
                            {"src":"mushroom/074.gif" ,"alt":"[s:283]"},
                            {"src":"mushroom/073.gif" ,"alt":"[s:282]"},
                            {"src":"mushroom/072.gif" ,"alt":"[s:281]"},
                            {"src":"mushroom/071.gif" ,"alt":"[s:280]"},
                            {"src":"mushroom/070.gif" ,"alt":"[s:279]"},
                            {"src":"mushroom/069.gif" ,"alt":"[s:278]"},
                            {"src":"mushroom/068.gif" ,"alt":"[s:277]"},
                            {"src":"mushroom/067.gif" ,"alt":"[s:276]"},
                            {"src":"mushroom/066.gif" ,"alt":"[s:275]"},
                            {"src":"mushroom/065.gif" ,"alt":"[s:274]"},
                            {"src":"mushroom/064.gif" ,"alt":"[s:273]"},
                            {"src":"mushroom/063.gif" ,"alt":"[s:272]"},
                            {"src":"mushroom/062.gif" ,"alt":"[s:271]"},
                            {"src":"mushroom/061.gif" ,"alt":"[s:270]"},
                            {"src":"mushroom/060.gif" ,"alt":"[s:269]"},
                            {"src":"mushroom/059.gif" ,"alt":"[s:268]"},
                            {"src":"mushroom/039.gif" ,"alt":"[s:248]"},
                            {"src":"mushroom/038.gif" ,"alt":"[s:247]"},
                            {"src":"mushroom/018.gif" ,"alt":"[s:227]"},
                            {"src":"mushroom/017.gif" ,"alt":"[s:226]"},
                            {"src":"mushroom/016.gif" ,"alt":"[s:225]"},
                            {"src":"mushroom/015.gif" ,"alt":"[s:224]"},
                            {"src":"mushroom/014.gif" ,"alt":"[s:223]"},
                            {"src":"mushroom/013.gif" ,"alt":"[s:222]"},
                            {"src":"mushroom/012.gif" ,"alt":"[s:221]"},
                            {"src":"mushroom/011.gif" ,"alt":"[s:220]"},
                            {"src":"mushroom/010.gif" ,"alt":"[s:219]"},
                            {"src":"mushroom/009.gif" ,"alt":"[s:218]"},
                            {"src":"mushroom/008.gif" ,"alt":"[s:217]"},
                            {"src":"mushroom/007.gif" ,"alt":"[s:216]"},
                            {"src":"mushroom/006.gif" ,"alt":"[s:215]"},
                            {"src":"mushroom/005.gif" ,"alt":"[s:214]"},
                            {"src":"mushroom/004.gif" ,"alt":"[s:213]"},
                            {"src":"mushroom/003.gif" ,"alt":"[s:212]"},
                            {"src":"mushroom/002.gif" ,"alt":"[s:211]"},
                            {"src":"mushroom/019.gif" ,"alt":"[s:228]"},
                            {"src":"mushroom/020.gif" ,"alt":"[s:229]"},
                            {"src":"mushroom/037.gif" ,"alt":"[s:246]"},
                            {"src":"mushroom/036.gif" ,"alt":"[s:245]"},
                            {"src":"mushroom/035.gif" ,"alt":"[s:244]"},
                            {"src":"mushroom/034.gif" ,"alt":"[s:243]"},
                            {"src":"mushroom/033.gif" ,"alt":"[s:242]"},
                            {"src":"mushroom/032.gif" ,"alt":"[s:241]"},
                            {"src":"mushroom/031.gif" ,"alt":"[s:240]"},
                            {"src":"mushroom/030.gif" ,"alt":"[s:239]"},
                            {"src":"mushroom/029.gif" ,"alt":"[s:238]"},
                            {"src":"mushroom/028.gif" ,"alt":"[s:237]"},
                            {"src":"mushroom/027.gif" ,"alt":"[s:236]"},
                            {"src":"mushroom/026.gif" ,"alt":"[s:235]"},
                            {"src":"mushroom/025.gif" ,"alt":"[s:234]"},
                            {"src":"mushroom/024.gif" ,"alt":"[s:233]"},
                            {"src":"mushroom/023.gif" ,"alt":"[s:232]"},
                            {"src":"mushroom/022.gif" ,"alt":"[s:231]"},
                            {"src":"mushroom/021.gif" ,"alt":"[s:230]"},
                            {"src":"mushroom/001.gif" ,"alt":"[s:210]"}]


                    },
                    {
                        "tag": "yang",
                        "list": [
                            {"src":"yang/203.gif" ,"alt":"[s:633]"},
                            {"src":"yang/40.gif" ,"alt":"[s:103]"},
                            {"src":"yang/39.gif" ,"alt":"[s:102]"},
                            {"src":"yang/38.gif" ,"alt":"[s:101]"},
                            {"src":"yang/34.gif" ,"alt":"[s:100]"},
                            {"src":"yang/28.gif" ,"alt":"[s:99]"},
                            {"src":"yang/27.gif" ,"alt":"[s:98]"},
                            {"src":"yang/26.gif" ,"alt":"[s:97]"},
                            {"src":"yang/25.gif" ,"alt":"[s:96]"},
                            {"src":"yang/22.gif" ,"alt":"[s:95]"},
                            {"src":"yang/20.gif" ,"alt":"[s:94]"},
                            {"src":"yang/10.gif" ,"alt":"[s:93]"},
                            {"src":"yang/8.gif"  ,"alt":"[s:92]"},
                            {"src":"yang/69.gif" ,"alt":"[s:86]"},
                            {"src":"yang/68.gif" ,"alt":"[s:85]"},
                            {"src":"yang/66.gif" ,"alt":"[s:84]"},
                            {"src":"yang/65.gif" ,"alt":"[s:83]"},
                            {"src":"yang/41.gif" ,"alt":"[s:104]"},
                            {"src":"yang/42.gif" ,"alt":"[s:105]"},
                            {"src":"yang/202.gif" ,"alt":"[s:287]"},
                            {"src":"yang/201.gif" ,"alt":"[s:286]"},
                            {"src":"yang/70.gif" ,"alt":"[s:119]"},
                            {"src":"yang/67.gif" ,"alt":"[s:118]"},
                            {"src":"yang/64.gif" ,"alt":"[s:117]"},
                            {"src":"yang/63.gif" ,"alt":"[s:116]"},
                            {"src":"yang/62.gif" ,"alt":"[s:115]"},
                            {"src":"yang/61.gif" ,"alt":"[s:114]"},
                            {"src":"yang/60.gif" ,"alt":"[s:113]"},
                            {"src":"yang/58.gif" ,"alt":"[s:112]"},
                            {"src":"yang/57.gif" ,"alt":"[s:111]"},
                            {"src":"yang/56.gif" ,"alt":"[s:110]"},
                            {"src":"yang/50.gif" ,"alt":"[s:109]"},
                            {"src":"yang/49.gif" ,"alt":"[s:108]"},
                            {"src":"yang/44.gif" ,"alt":"[s:107]"},
                            {"src":"yang/43.gif" ,"alt":"[s:106]"},
                            {"src":"yang/59.gif" ,"alt":"[s:82]"},
                            {"src":"yang/55.gif" ,"alt":"[s:80]"},
                            {"src":"yang/18.gif" ,"alt":"[s:57]"},
                            {"src":"yang/19.gif" ,"alt":"[s:58]"},
                            {"src":"yang/21.gif" ,"alt":"[s:59]"},
                            {"src":"yang/23.gif","alt":"[s:60]"},
                            {"src":"yang/24.gif","alt":"[s:61]"},
                            {"src":"yang/4.gif","alt":"[s:91]"},
                            {"src":"yang/29.gif","alt":"[s:63]"},
                            {"src":"yang/30.gif","alt":"[s:64]"},
                            {"src":"yang/31.gif","alt":"[s:65]"},
                            {"src":"yang/32.gif","alt":"[s:66]"},
                            {"src":"yang/33.gif","alt":"[s:67]"},
                            {"src":"yang/35.gif","alt":"[s:68]"},
                            {"src":"yang/36.gif","alt":"[s:69]"},
                            {"src":"yang/37.gif","alt":"[s:70]"},
                            {"src":"yang/45.gif","alt":"[s:72]"},
                            {"src":"yang/46.gif","alt":"[s:73]"},
                            {"src":"yang/17.gif","alt":"[s:56]"},
                            {"src":"yang/16.gif","alt":"[s:55]"},
                            {"src":"yang/53.gif","alt":"[s:79]"},
                            {"src":"yang/52.gif","alt":"[s:78]"},
                            {"src":"yang/51.gif","alt":"[s:77]"},
                            {"src":"yang/48.gif","alt":"[s:75]"},
                            {"src":"yang/2.gif","alt":"[s:43]"},
                            {"src":"yang/3.gif","alt":"[s:44]"},
                            {"src":"yang/5.gif","alt":"[s:45]"},
                            {"src":"yang/6.gif","alt":"[s:46]"},
                            {"src":"yang/7.gif","alt":"[s:47]"},
                            {"src":"yang/9.gif","alt":"[s:49]"},
                            {"src":"yang/11.gif","alt":"[s:50]"},
                            {"src":"yang/12.gif","alt":"[s:51]"},
                            {"src":"yang/13.gif","alt":"[s:52]"},
                            {"src":"yang/14.gif","alt":"[s:53]"},
                            {"src":"yang/15.gif","alt":"[s:54]"},
                            {"src":"yang/47.gif","alt":"[s:74]"}
                        ]
                    },
                    {
                        "tag": "too",
                        "list": [
                            {"src":"too/33.gif" ,"alt":"[s:90]"},
                            {"src":"too/13.gif" ,"alt":"[s:23]"},
                            {"src":"too/12.gif" ,"alt":"[s:22]"},
                            {"src":"too/11.gif" ,"alt":"[s:21]"},
                            {"src":"too/10.gif" ,"alt":"[s:20]"},
                            {"src":"too/9.gif" ,"alt":"[s:19]"},
                            {"src":"too/8.gif" ,"alt":"[s:18]"},
                            {"src":"too/7.gif" ,"alt":"[s:17]"},
                            {"src":"too/6.gif" ,"alt":"[s:16]"},
                            {"src":"too/5.gif" ,"alt":"[s:15]"},
                            {"src":"too/4.gif" ,"alt":"[s:14]"},
                            {"src":"too/3.gif" ,"alt":"[s:13]"},
                            {"src":"too/2.gif" ,"alt":"[s:12]"},
                            {"src":"too/1.gif" ,"alt":"[s:11]"},
                            {"src":"too/31.gif" ,"alt":"[s:88]"},
                            {"src":"too/14.gif" ,"alt":"[s:24]"},
                            {"src":"too/15.gif" ,"alt":"[s:25]"},
                            {"src":"too/16.gif" ,"alt":"[s:26]"},
                            {"src":"too/32.gif" ,"alt":"[s:89]"},
                            {"src":"too/30.gif" ,"alt":"[s:40]"},
                            {"src":"too/28.gif" ,"alt":"[s:38]"},
                            {"src":"too/27.gif" ,"alt":"[s:37]"},
                            {"src":"too/26.gif" ,"alt":"[s:36]"},
                            {"src":"too/25.gif" ,"alt":"[s:35]"},
                            {"src":"too/24.gif" ,"alt":"[s:34]"},
                            {"src":"too/23.gif" ,"alt":"[s:33]"},
                            {"src":"too/22.gif" ,"alt":"[s:32]"},
                            {"src":"too/21.gif" ,"alt":"[s:31]"},
                            {"src":"too/20.gif" ,"alt":"[s:30]"},
                            {"src":"too/19.gif" ,"alt":"[s:29]"},
                            {"src":"too/18.gif" ,"alt":"[s:28]"},
                            {"src":"too/17.gif" ,"alt":"[s:27]"},
                            {"src":"too/29.gif" ,"alt":"[s:87]"}
                        ]
                    },
                    {
                        "tag":"tuerkong",
                        "list":[{"src":"tuerkong/1.gif" ,"alt":"[s:291]"},
                        {"src":"tuerkong/19.gif" ,"alt":"[s:309]"},
                        {"src":"tuerkong/20.gif" ,"alt":"[s:310]"},
                        {"src":"tuerkong/21.gif" ,"alt":"[s:311]"},
                        {"src":"tuerkong/22.gif" ,"alt":"[s:312]"},
                        {"src":"tuerkong/23.gif" ,"alt":"[s:313]"},
                        {"src":"tuerkong/24.gif" ,"alt":"[s:314]"},
                        {"src":"tuerkong/25.gif" ,"alt":"[s:315]"},
                        {"src":"tuerkong/26.gif" ,"alt":"[s:316]"},
                        {"src":"tuerkong/27.gif" ,"alt":"[s:317]"},
                        {"src":"tuerkong/28.gif" ,"alt":"[s:318]"},
                        {"src":"tuerkong/29.gif" ,"alt":"[s:319]"},
                        {"src":"tuerkong/30.gif" ,"alt":"[s:320]"},
                        {"src":"tuerkong/31.gif" ,"alt":"[s:321]"},
                        {"src":"tuerkong/32.gif" ,"alt":"[s:322]"},
                        {"src":"tuerkong/18.gif" ,"alt":"[s:308]"},
                        {"src":"tuerkong/17.gif" ,"alt":"[s:307]"},
                        {"src":"tuerkong/16.gif" ,"alt":"[s:306]"},
                        {"src":"tuerkong/2.gif" ,"alt":"[s:292]"},
                        {"src":"tuerkong/3.gif" ,"alt":"[s:293]"},
                        {"src":"tuerkong/4.gif" ,"alt":"[s:294]"},
                        {"src":"tuerkong/5.gif" ,"alt":"[s:295]"},
                        {"src":"tuerkong/6.gif" ,"alt":"[s:296]"},
                        {"src":"tuerkong/7.gif" ,"alt":"[s:297]"},
                        {"src":"tuerkong/8.gif" ,"alt":"[s:298]"},
                        {"src":"tuerkong/9.gif" ,"alt":"[s:299]"},
                        {"src":"tuerkong/10.gif" ,"alt":"[s:300]"},
                        {"src":"tuerkong/11.gif" ,"alt":"[s:301]"},
                        {"src":"tuerkong/12.gif" ,"alt":"[s:302]"},
                        {"src":"tuerkong/13.gif" ,"alt":"[s:303]"},
                        {"src":"tuerkong/14.gif" ,"alt":"[s:304]"},
                        {"src":"tuerkong/15.gif" ,"alt":"[s:305]"},
                        {"src":"tuerkong/33.gif" ,"alt":"[s:323]"}]
                    },
                    {
                        "tag":"lu",
                        "list":[{"src":"lu/01.gif" ,"alt":"[s:763]"},
                        {"src":"lu/16.gif" ,"alt":"[s:778]"},
                        {"src":"lu/15.gif" ,"alt":"[s:777]"},
                        {"src":"lu/14.gif" ,"alt":"[s:776]"},
                        {"src":"lu/13.gif" ,"alt":"[s:775]"},
                        {"src":"lu/12.gif" ,"alt":"[s:774]"},
                        {"src":"lu/11.gif" ,"alt":"[s:773]"},
                        {"src":"lu/10.gif" ,"alt":"[s:772]"},
                        {"src":"lu/09.gif" ,"alt":"[s:771]"},
                        {"src":"lu/08.gif" ,"alt":"[s:770]"},
                        {"src":"lu/07.gif" ,"alt":"[s:769]"},
                        {"src":"lu/06.gif" ,"alt":"[s:768]"},
                        {"src":"lu/05.gif" ,"alt":"[s:767]"},
                        {"src":"lu/04.gif" ,"alt":"[s:766]"},
                        {"src":"lu/03.gif" ,"alt":"[s:765]"},
                        {"src":"lu/02.gif" ,"alt":"[s:764]"},
                        {"src":"lu/17.gif" ,"alt":"[s:779]"}]
                    },
                    {
                        "tag":"alu",
                        "list":[{"src":"alu/83.gif" ,"alt":"[a:1196]"},
                        {"src":"alu/66.gif" ,"alt":"[a:1179]"},
                        {"src":"alu/65.gif" ,"alt":"[a:1178]"},
                        {"src":"alu/64.gif" ,"alt":"[a:1177]"},
                        {"src":"alu/63.gif" ,"alt":"[a:1176]"},
                        {"src":"alu/62.gif" ,"alt":"[a:1175]"},
                        {"src":"alu/61.gif" ,"alt":"[a:1174]"},
                        {"src":"alu/60.gif" ,"alt":"[a:1173]"},
                        {"src":"alu/59.gif" ,"alt":"[a:1172]"},
                        {"src":"alu/58.gif" ,"alt":"[a:1171]"},
                        {"src":"alu/57.gif" ,"alt":"[a:1170]"},
                        {"src":"alu/56.gif" ,"alt":"[a:1169]"},
                        {"src":"alu/55.gif" ,"alt":"[a:1168]"},
                        {"src":"alu/54.gif" ,"alt":"[a:1167]"},
                        {"src":"alu/67.gif" ,"alt":"[a:1180]"},
                        {"src":"alu/68.gif" ,"alt":"[a:1181]"},
                        {"src":"alu/69.gif" ,"alt":"[a:1182]"},
                        {"src":"alu/82.gif" ,"alt":"[a:1195]"},
                        {"src":"alu/81.gif" ,"alt":"[a:1194]"},
                        {"src":"alu/80.gif" ,"alt":"[a:1193]"},
                        {"src":"alu/79.gif" ,"alt":"[a:1192]"},
                        {"src":"alu/78.gif" ,"alt":"[a:1191]"},
                        {"src":"alu/77.gif" ,"alt":"[a:1190]"},
                        {"src":"alu/76.gif" ,"alt":"[a:1189]"},
                        {"src":"alu/75.gif" ,"alt":"[a:1188]"},
                        {"src":"alu/74.gif" ,"alt":"[a:1187]"},
                        {"src":"alu/73.gif" ,"alt":"[a:1186]"},
                        {"src":"alu/72.gif" ,"alt":"[a:1185]"},
                        {"src":"alu/71.gif" ,"alt":"[a:1184]"},
                        {"src":"alu/70.gif" ,"alt":"[a:1183]"},
                        {"src":"alu/53.gif" ,"alt":"[a:1166]"},
                        {"src":"alu/52.gif" ,"alt":"[a:1165]"},
                        {"src":"alu/35.gif" ,"alt":"[a:1148]"},
                        {"src":"alu/34.gif" ,"alt":"[a:1147]"},
                        {"src":"alu/33.gif" ,"alt":"[a:1146]"},
                        {"src":"alu/32.gif" ,"alt":"[a:1145]"},
                        {"src":"alu/31.gif" ,"alt":"[a:1144]"},
                        {"src":"alu/30.gif" ,"alt":"[a:1143]"},
                        {"src":"alu/29.gif" ,"alt":"[a:1142]"},
                        {"src":"alu/28.gif" ,"alt":"[a:1141]"},
                        {"src":"alu/27.gif" ,"alt":"[a:1140]"},
                        {"src":"alu/26.gif" ,"alt":"[a:1139]"},
                        {"src":"alu/25.gif" ,"alt":"[a:1138]"},
                        {"src":"alu/24.gif" ,"alt":"[a:1137]"},
                        {"src":"alu/23.gif" ,"alt":"[a:1136]"},
                        {"src":"alu/36.gif" ,"alt":"[a:1149]"},
                        {"src":"alu/37.gif" ,"alt":"[a:1150]"},
                        {"src":"alu/38.gif" ,"alt":"[a:1151]"},
                        {"src":"alu/51.gif" ,"alt":"[a:1164]"},
                        {"src":"alu/50.gif" ,"alt":"[a:1163]"},
                        {"src":"alu/49.gif" ,"alt":"[a:1162]"},
                        {"src":"alu/48.gif" ,"alt":"[a:1161]"},
                        {"src":"alu/47.gif" ,"alt":"[a:1160]"},
                        {"src":"alu/46.gif" ,"alt":"[a:1159]"},
                        {"src":"alu/45.gif" ,"alt":"[a:1158]"},
                        {"src":"alu/44.gif" ,"alt":"[a:1157]"},
                        {"src":"alu/43.gif" ,"alt":"[a:1156]"},
                        {"src":"alu/42.gif" ,"alt":"[a:1155]"},
                        {"src":"alu/41.gif" ,"alt":"[a:1154]"},
                        {"src":"alu/40.gif" ,"alt":"[a:1153]"},
                        {"src":"alu/39.gif" ,"alt":"[a:1152]"},
                        {"src":"alu/22.gif" ,"alt":"[a:1135]"}]
                    },
                    {
                      "tag":"yellowface",
                      "list": [{"src":"yellowface/(15).gif","alt":"[s:667]"},
                      {"src":"yellowface/(29).gif","alt":"[s:648]"},
                      {"src":"yellowface/(28).gif","alt":"[s:647]"},
                      {"src":"yellowface/(27).gif","alt":"[s:646]"},
                      {"src":"yellowface/(26).gif","alt":"[s:645]"},
                      {"src":"yellowface/(25).gif","alt":"[s:644]"},
                      {"src":"yellowface/(24).gif","alt":"[s:643]"},
                      {"src":"yellowface/(23).gif","alt":"[s:642]"},
                      {"src":"yellowface/(22).gif","alt":"[s:641]"},
                      {"src":"yellowface/(21).gif","alt":"[s:640]"},
                      {"src":"yellowface/1.gif","alt":"[s:639]"},
                      {"src":"yellowface/(20).gif","alt":"[s:638]"},
                      {"src":"yellowface/(19).gif","alt":"[s:637]"},
                      {"src":"yellowface/(18).gif","alt":"[s:636]"},
                      {"src":"yellowface/(17).gif","alt":"[s:635]"},
                      {"src":"yellowface/(6).gif","alt":"[s:658]"},
                      {"src":"yellowface/(30).gif","alt":"[s:649]"},
                      {"src":"yellowface/(31).gif","alt":"[s:650]"},
                      {"src":"yellowface/(14).gif","alt":"[s:666]"},
                      {"src":"yellowface/(13).gif","alt":"[s:665]"},
                      {"src":"yellowface/(12).gif","alt":"[s:664]"},
                      {"src":"yellowface/(11).gif","alt":"[s:663]"},
                      {"src":"yellowface/(10).gif","alt":"[s:662]"},
                      {"src":"yellowface/(9).gif","alt":"[s:661]"},
                      {"src":"yellowface/(8).gif","alt":"[s:660]"},
                      {"src":"yellowface/(7).gif","alt":"[s:659]"},
                      {"src":"yellowface/(38).gif","alt":"[s:657]"},
                      {"src":"yellowface/(37).gif","alt":"[s:656]"},
                      {"src":"yellowface/(36).gif","alt":"[s:655]"},
                      {"src":"yellowface/(35).gif","alt":"[s:654]"},
                      {"src":"yellowface/(34).gif","alt":"[s:653]"},
                      {"src":"yellowface/(33).gif","alt":"[s:652]"},
                      {"src":"yellowface/(32).gif","alt":"[s:651]"},
                      {"src":"yellowface/(16).gif","alt":"[s:634]"}]
                    }
                ]
            }
''';