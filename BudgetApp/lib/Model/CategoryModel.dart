class Category {
  const Category(this.name);
  final String name;
}

class CategoryGetter {
  static List<Category> users = <Category>[
    const Category('Shopping'),
    const Category('Grocery'),
    const Category('Education'),
    const Category('Others'),
  ];

}
