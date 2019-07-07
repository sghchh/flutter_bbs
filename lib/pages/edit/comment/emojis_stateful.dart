import 'package:flutter/material.dart';
import 'package:flutter_bbs/utils/emojis_util.dart' as emojis_util;
class EmojisStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmojisState();
  }

}

class EmojisState extends State<EmojisStateful> {
  int emojisId = 0;      // 代表选择哪种表情包
  int tapId = 0;         // 代表选择哪个表情包
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // 首先是一行用来选择表情包的种类的UI
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1))
            ),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: emojis_util.emojis.emojis.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.all(5),
                      child: Image.network("${emojis_util.baseURL}${emojis_util.emojis.emojis[index].list[0].src}",
                        height: 35,
                        width: 35,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        this.emojisId = index;
                      });
                    },
                  );
                }),
          ),
          Expanded(
            // 其次是该类别下所有的表情包
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: emojis_util.emojis.emojis[emojisId].list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3
                    ),
                    itemBuilder: (context, index){
                      return GestureDetector(
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.all(5),
                          child: Image.network("${emojis_util.baseURL}${emojis_util.emojis.emojis[emojisId].list[index].src}",
                            height: 35,
                            width: 35,
                          ),
                        ),
                        onTap: () {
                          this.tapId = index;
                          String emojisUrl = "[mobcent_phiz=${emojis_util.baseURL}${emojis_util.emojis.emojis[emojisId].list[tapId].src}]";
                          String emojisAlt = emojis_util.emojis.emojis[emojisId].list[tapId].alt;
                          emojis_util.EmojisIndex i = emojis_util.EmojisIndex();
                          i.url = emojisUrl;
                          i.alt = emojisAlt;
                          // 将添加的表情对应的alt回写进TextField上
                          emojis_util.appendEmojis(i);
                          Navigator.of(context).pop();
                        },
                      );
                    })
            ),
          )
        ],
      ),
    );
  }


}