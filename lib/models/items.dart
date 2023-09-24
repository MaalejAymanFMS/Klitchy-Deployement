class Items {
  List<Item>? data;

  Items({this.data});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      data: (json['data'] as List?)?.map((e) => Item.fromJson(e)).toList(),
    );
  }
}

class Item {
  String? itemName;
  String? image;
  double? standardRate;

  Item({this.itemName, this.image, this.standardRate});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemName: json['item_name'] ?? 'null name',
      image: json['image'] ?? 'null image',
      standardRate: json['standard_rate']?.toDouble() ?? 0.0,
    );
  }
}




