class Item {
  final String? txt;
  final String? image;

  Item({this.txt, this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      txt: json['txt'],
      image: json['image'],
    );
  }
}

class HomePageDataModel {
  final List<Item> items;

  HomePageDataModel({required this.items});

  factory HomePageDataModel.fromJson(List<dynamic> json) {
    List<Item> itemList = json.map((i) => Item.fromJson(i)).toList();
    return HomePageDataModel(items: itemList);
  }
}