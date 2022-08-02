class SearchModel {
  bool? status;
  String? message;
  Data? data;

  SearchModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<Product> data = [];

  int? from;
  int? lastPage;

  String? path;
  int? perPage;
  int? to;
  int? total;

  Data.fromJson(Map<dynamic, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];

      json['data'].forEach((element) {
        data.add(Product.fromJson(element));
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

class Product {
  int? id;

  int? price;
  int? oldPrice;
  int? discount;
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
