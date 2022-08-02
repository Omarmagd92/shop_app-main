import '../../../../layout/shop_app/cubit/statue.dart';
import '../../../../models/shop_model/shop_model.dart';

abstract class ShopLoginStatues {}

class ShopLoginInitialStatue extends ShopLoginStatues {}

class ShopLoginLoadingStatue extends ShopLoginStatues {}

class ShopLoginSuccessStatue extends ShopLoginStatues {
  final ShopLoginModel loginModel;

  ShopLoginSuccessStatue(this.loginModel);
}

class ShopLoginErrorStatue extends ShopLoginStatues {
  final String error;

  ShopLoginErrorStatue(this.error);
}

class ShopChangePasswordStatue extends ShopLoginStatues {}

class UpdateProfileLoadingState extends ShopStates {}

class UpdateProfileSuccessState extends ShopStates {
  final ShopLoginModel updateUserModel;

  UpdateProfileSuccessState(this.updateUserModel);
}

class UpdateProfileErrorState extends ShopStates {}

///General States
class InitialState extends ShopStates {}

class ChangeModeState extends ShopStates {}

class ChangeBottomNavState extends ShopStates {}

class ChangeSuffixIconState extends ShopStates {}

class GetTokenSuccessState extends ShopStates {}

class EditPressedState extends ShopStates {}

class CloseTopSheet extends ShopStates {}

class RefreshPage extends ShopStates {}

///End of General states
