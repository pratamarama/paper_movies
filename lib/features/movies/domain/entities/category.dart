/// Created by Pratama Ramadhan on 18/09/26.

class Category {
  final String name;
  final int rateValue;
  final bool activeStatus;

  const Category({required this.name, required this.rateValue, required this.activeStatus});

  Category copyWith({
    String? name,
    int? rateValue,
    bool? activeStatus,
  }) {
    return Category(
      name: name ?? this.name,
      rateValue: rateValue ?? this.rateValue,
      activeStatus: activeStatus ?? this.activeStatus,
    );
  }
}
