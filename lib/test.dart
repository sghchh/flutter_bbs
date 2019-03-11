
class Category {
  String board_category_name;
  var board_list;

  Category(this.board_category_name, this.board_list);
}

class Board {
  String board_id;

  Board(this.board_id);
}

List<Category> test = <Category>[Category('成电校园', <Board>[Board("关云长"), Board("张翼德"), Board("刘玄德"), Board('曹孟德')])];