class Category {
  const Category(this.name, this.imagePath);
  final String name;
  final String imagePath;
}

class CategoryGetter {
  static List<Category> users = <Category>[
    const Category('Entertainment', 'asset/image/category/Entertainment.png'),
    const Category('Drink', 'asset/image/category/Drink.png'),
    const Category('Grocery', 'asset/image/category/Grocery.png'),
    const Category('Food', 'asset/image/category/Food.png'),
    const Category('Healthcare', 'asset/image/category/Healthcare.png'),
    const Category('Shopping', 'asset/image/category/Shopping.png'),
    const Category('Education', 'asset/image/category/Education.png'),
    const Category('Tax', 'asset/image/category/Tax.png'),
    const Category('Rent', 'asset/image/category/Rent.png'),
    const Category('Fee', 'asset/image/category/fee.png'),
    const Category('Others', 'asset/image/category/other.png'),
  ];

  static String getImage(String name) {
    var index = users.indexWhere((element) => element.name == name);
    return users[index].imagePath;
  }
}
