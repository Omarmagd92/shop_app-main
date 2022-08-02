class ChangeToFavoritesModel {
  late bool status;
  String? message;

  ChangeToFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
