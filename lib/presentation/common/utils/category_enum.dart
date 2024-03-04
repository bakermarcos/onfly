enum Category {
  outros,
  lazer,
  compras,
  contas;

  static Category fromString(String? text) {
    for (final element in Category.values) {
      if (element.name == text) {
        return element;
      }
    }
    return Category.outros;
  }
}
