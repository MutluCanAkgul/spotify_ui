class Item {
  final String? txt;
  final String? image;
  final String? turu;
  final String? sanatci;

  Item({this.txt, this.image,this.turu,this.sanatci});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      txt: json['txt'],
      image: json['image'],
      turu: json['turu'],
      sanatci: json['sanatci'],
    );
  }
}

class LibraryPageDataModel {
  final List<Item> items;

 LibraryPageDataModel ({required this.items});

  factory LibraryPageDataModel .fromJson(List<dynamic> json) {
    List<Item> itemList = json.map((i) => Item.fromJson(i)).toList();
    return LibraryPageDataModel (items: itemList);
  }
}
