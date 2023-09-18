class Categories {
  List<Data>? data;

  Categories({this.data});

  factory Categories.fromJson(Map<String, dynamic>? json) {
    return Categories(
      data: (json?['data'] as List?)?.map((e) => Data.fromJson(e)).toList(),
    );
  }
}
class Data {
  String? name;
  Data({this.name});
  factory Data.fromJson(Map<String, dynamic>? json) {
    return Data(

        name: json?['name'],
    );

  }
}