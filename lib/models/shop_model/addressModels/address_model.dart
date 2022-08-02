/*
{
    "status": true,
    "message": "تمت الإضافة بنجاح",
    "data": {
        "name": "Work",
        "city": "Cairo",
        "region": "Nasr City",
        "details": "7 Wahran str",
        "latitude": 30.061686300000001637044988456182181835174560546875,
        "longitude": 31.326008800000000320551407639868557453155517578125,
        "id": 728
    }
}
 */
class GetAddressModel {
  bool? status;
  AddressPage? data;
  AddressData? addressData;

  GetAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? AddressPage.fromJson(json['data']) : null;
    addressData = json['addressData'] != null
        ? AddressData.fromJson(json['addressData'])
        : null;
  }
}

class GetAddressData {
  List<AddressData> data = [];

  GetAddressData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => AddressData.fromJson(e)).toList();
  }
}

class ChangeAddressModel {
  late bool status;
  String? message;
  late AddressData data;

  ChangeAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = AddressData.fromJson(json['data']);
  }
}

class AddressPage {
  int? currentPage;
  List<AddressData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  AddressPage.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new AddressData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class AddressData {
  late int id;
  late String name;
  late String city;
  late String region;
  late String details;
  String? notes;
  double? latitude;
  double? longitude;

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
