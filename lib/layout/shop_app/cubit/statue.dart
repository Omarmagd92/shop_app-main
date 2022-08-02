import '../../../models/shop_model/addressModels/address_model.dart';
import '../../../models/shop_model/cartModels/addCartModel.dart';
import '../../../models/shop_model/cartModels/order_model.dart';
import '../../../models/shop_model/cartModels/updateCartModel.dart';
import '../../../models/shop_model/change_fav_model.dart';
import '../../../models/shop_model/shop_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {}

class ShopErrorHomeState extends ShopStates {
  final String error;

  ShopErrorHomeState(this.error);
}

class ShopLoadingCategoryState extends ShopStates {}

class ShopSuccessCategoryState extends ShopStates {}

class ShopErrorCategoryState extends ShopStates {}

class CategoryDetailsLoadingState extends ShopStates {}

class CategoryDetailsSuccessState extends ShopStates {}

class CategoryDetailsErrorState extends ShopStates {}

class ShopChangeCartItemState extends ShopStates {}

class ShopSuccessChangeCartItemState extends ShopStates {
  final AddCartModel model;

  ShopSuccessChangeCartItemState(this.model);
}

class ShopErrorChangeCartItemState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeToFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopUpdateQuantityItemState extends ShopStates {}

class ShopSuccessUpdateQuantityItemState extends ShopStates {
  final UpdateCartModel model;

  ShopSuccessUpdateQuantityItemState(this.model);
}

class ShopErrorUpdateQuantityItemState extends ShopStates {}

class ShopChangeFavState extends ShopStates {}

class ShopSuccessChangeFavState extends ShopStates {
  late final ChangeToFavoritesModel model;

  ShopSuccessChangeFavState(this.model);
}

class ShopErrorChangeFavState extends ShopStates {}

class ShopLoadingChangeFavState extends ShopStates {}

class ChangeFavoritesManuallySuccessState extends ShopStates {}

class ChangeFavoritesErrorState extends ShopStates {}

class ShopSuccessGetFavState extends ShopStates {}

class ShopErrorGetFavState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  late final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}

class SearchInitialState extends ShopStates {}

class SearchLoadingState extends ShopStates {}

class SearchSuccessState extends ShopStates {}

class SearchErrorState extends ShopStates {
  final String error;

  SearchErrorState(this.error);
}

class ProfileLoadingState extends ShopStates {}

class ProfileSuccessState extends ShopStates {}

class ProfileErrorState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {
  late final ShopLoginModel updateUserModel;

  ShopSuccessUpdateUserDataState(this.updateUserModel);
}

class ShopErrorUpdateUserDataState extends ShopStates {}

class AddOrderLoadingState extends ShopStates {}

class AddOrderSuccessState extends ShopStates {
  final AddOrderModel addOrderModel;

  AddOrderSuccessState(this.addOrderModel);
}

class AddOrderErrorState extends ShopStates {
  final String error;

  AddOrderErrorState(this.error);
}

///ChangePassword State
class ChangePassLoadingState extends ShopStates {}

class ChangePassSuccessState extends ShopStates {
  final ShopLoginModel passUserModel;

  ChangePassSuccessState(this.passUserModel);
}

class ChangePassErrorState extends ShopStates {}

///End of ChangePassword State

///Cart State
class CartLoadingState extends ShopStates {}

class CartSuccessState extends ShopStates {}

class CartErrorState extends ShopStates {}

///End of Cart State
class AddCartLoadingState extends ShopStates {}

class AddCartSuccessState extends ShopStates {
  final AddCartModel addCartModel;

  AddCartSuccessState(this.addCartModel);
}

class AddCartErrorState extends ShopStates {}

///Cart State
class UpdateCartLoadingState extends ShopStates {}

class UpdateCartSuccessState extends ShopStates {}

class UpdateCartErrorState extends ShopStates {}

class MinusCartItemState extends ShopStates {}

class PlusCartItemState extends ShopStates {}

class GetAddressesLoadingState extends ShopStates {}

class GetAddressesSuccessState extends ShopStates {
  final GetAddressModel addressModel;

  GetAddressesSuccessState(this.addressModel);
}

class GetAddressesErrorState extends ShopStates {
  final String error;

  GetAddressesErrorState(this.error);
}

class CancelOrderLoadingState extends ShopStates {}

class CancelOrderSuccessState extends ShopStates {
  final CancelOrderModel cancelOrderModel;

  CancelOrderSuccessState(this.cancelOrderModel);
}

class CancelOrderErrorState extends ShopStates {
  final String error;

  CancelOrderErrorState(this.error);
}

class GetOrdersLoadingState extends ShopStates {}

class GetOrdersSuccessState extends ShopStates {
  final GetOrderModel getOrderModel;

  GetOrdersSuccessState(this.getOrderModel);
}

class GetOrdersErrorState extends ShopStates {
  final String error;

  GetOrdersErrorState(this.error);
}

class OrderDetailsLoadingState extends ShopStates {}

class OrderDetailsSuccessState extends ShopStates {
  final OrderDetailsModel orderDetailsModel;

  OrderDetailsSuccessState(this.orderDetailsModel);
}

class OrderDetailsErrorState extends ShopStates {
  final String error;

  OrderDetailsErrorState(this.error);
}

class ProductLoadingState extends ShopStates {}

class ProductSuccessState extends ShopStates {}

class ProductErrorState extends ShopStates {}

class FAQsLoadingState extends ShopStates {}

class FAQsSuccessState extends ShopStates {}

class FAQsErrorState extends ShopStates {}

////Add Address State
class AddAddressLoadingState extends ShopStates {}

class AddAddressSuccessState extends ShopStates {
  final ChangeAddressModel addressModel;

  AddAddressSuccessState(this.addressModel);
}

class AddAddressErrorState extends ShopStates {}

///End of Add Address State

///Add Update Address State
class UpdateAddressLoadingState extends ShopStates {}

class UpdateAddressSuccessState extends ShopStates {
  final ChangeAddressModel addressModel;

  UpdateAddressSuccessState(this.addressModel);
}

class UpdateAddressErrorState extends ShopStates {}

///End of Add Address State

///Add Delete Address State
class DeleteAddressLoadingState extends ShopStates {}

class DeleteAddressSuccessState extends ShopStates {
  final ChangeAddressModel addressModel;

  DeleteAddressSuccessState(this.addressModel);
}

class DeleteAddressErrorState extends ShopStates {}

///End of delete Address State

///Addresses State
class AddressesLoadingState extends ShopStates {}

class AddressesSuccessState extends ShopStates {
  final GetAddressModel addressModel;

  AddressesSuccessState(this.addressModel);
}

class AddressesErrorState extends ShopStates {}

///End of Addresses State

class ShopDiscountState extends ShopStates {}

class ShopDicountOkState extends ShopStates {}

class ShopDicountErrorState extends ShopStates {
  final String error;

  ShopDicountErrorState(this.error);
}
