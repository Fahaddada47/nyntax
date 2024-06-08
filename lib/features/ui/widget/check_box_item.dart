class CheckboxItem {
  final String title;
  final double? price;
  final double? percentage;
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
      return '${percentage!.toStringAsFixed(2)}%';
    } else {
      return '';
    }
  }
}
