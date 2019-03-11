

class BoardPositionInfo {
  bool isBoard;       //表示该位置的数据是否代表着板块的分类
  int mather;         //如果该位置的数据是具体的板块，那么该属性代表着属于哪个位置的板块
  int index;         //如果该位置的数据不是板块的分类，而是具体的板块，那么该具体的板块在分类中的索引

  BoardPositionInfo(this.isBoard, this.mather, this.index);
}

List<BoardPositionInfo> getBoardIndex(List sourceData) {
  var finalList = <BoardPositionInfo>[];
  for (int i = 0; i < sourceData.length; i++) {
    var item = BoardPositionInfo(false, -1, -1);
    finalList.add(item);
    for (int j = 0; j < sourceData[i]; j++) {
      var item0 = BoardPositionInfo(true, i, j);
      finalList.add(item0);
    }
  }

  return finalList;
}