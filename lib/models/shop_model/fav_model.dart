class FavoriteModel {
  bool? status;
  String? message;
  Data? data;

  FavoriteModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic currentPage;
  List<FavData> data = [];

  dynamic from;
  dynamic lastPage;

  String? path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  Data.fromJson(Map<dynamic, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];

      json['data'].forEach((element) {
        data.add(FavData.fromJson(element));
      });
    }

    from = json['from'];

    lastPage = json['last_page'];

    path = json['path'];

    perPage = json['per_page'];

    to = json['to'];

    total = json['total'];
  }
}

class FavData {
  late dynamic id;
  late Product product;

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null
        ? new Product.fromJson(json['product'])
        : null)!;
  }
}

class Product {
  dynamic id;

  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    price = json['price'];

    oldPrice = json['old_price'];

    discount = json['discount'];

    image = json['image'];

    name = json['name'];

    description = json['description'];
  }
}
