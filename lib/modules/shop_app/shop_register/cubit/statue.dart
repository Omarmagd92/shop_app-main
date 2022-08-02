import '../../../../models/shop_model/shop_model.dart';

abstract class ShopRegisterStatues {}

class ShopRegisterInitialStatue extends ShopRegisterStatues {}

class ShopRegisterLoadingStatue extends ShopRegisterStatues {}

class ShopRegisterSuccessStatue extends ShopRegisterStatues {
  late final ShopLoginModel loginModel;

  ShopRegisterSuccessStatue(this.loginModel);
}

class ShopRegisterErrorStatue extends ShopRegisterStatues {
  final String error;

  ShopRegisterErrorStatue(this.error);
}

class ShopAddPasswordStatue extends ShopRegisterStatues {}
