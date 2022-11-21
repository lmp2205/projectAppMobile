import 'package:myshop/models/category.dart';


class Utils {
  static List<Category> getMockedCategories() {
    return [
      Category(title: 'Vàng', imgName: 'vang'),
      Category(title: 'Xe', imgName: 'xe'),
      Category(title: 'Bạc', imgName: 'bac'),
      Category(title: 'Điện Thoại', imgName: 'dienthoai'),
      Category(title: 'Khác', imgName: 'khac'),
    ];
  }
}
