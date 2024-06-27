class Item {
  final String? title;
  final String? image;

  Item({this.title, this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      image: json['image'],
    );
  }
}

class SearchPageLocalData {
  final List<Item> items;

  SearchPageLocalData({required this.items});

  factory SearchPageLocalData.fromJson(List<dynamic> json) {
    List<Item> itemList = json.map((i) => Item.fromJson(i)).toList();
    return SearchPageLocalData(items: itemList);
  }
}