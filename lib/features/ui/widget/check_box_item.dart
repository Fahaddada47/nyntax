class CheckboxItem {
  String title;
  double? price;
  double? percentage;
  bool value;

  CheckboxItem({
    required this.title,
    this.price,
    this.percentage,
    this.value = false,
  });

  String get secondaryText {
    if (price != null) {
      return '\$${price!.toStringAsFixed(2)}';
    } else if (percentage != null) {
      return '${percentage!.toStringAsFixed(1)}%';
    }
    return '';
  }
}