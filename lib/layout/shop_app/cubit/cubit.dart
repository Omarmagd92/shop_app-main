import 'package:ShopApp/layout/shop_app/cubit/statue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/shop_model/addressModels/address_model.dart';
import '../../../models/shop_model/cartModels/addCartModel.dart';
import '../../../models/shop_model/cartModels/cartModel.dart';
import '../../../models/shop_model/cartModels/order_model.dart';
import '../../../models/shop_model/cartModels/updateCartModel.dart';
import '../../../models/shop_model/categoriesDetailsModel.dart';
import '../../../models/shop_model/catogery_model.dart';
import '../../../models/shop_model/change_fav_model.dart';
import '../../../models/shop_model/fav_model.dart';
import '../../../models/shop_model/home_model.dart';
import '../../../models/shop_model/productDetialsModel.dart';
import '../../../models/shop_model/shop_model.dart';
import '../../../models/user_model/faqsModels.dart';
import '../../../modules/shop_app/catogries/categroies.dart';
import '../../../modules/shop_app/favorites/favorites.dart';
import '../../../modules/shop_app/home/home.dart';
import '../../../modules/shop_app/shop_login/cubit/statues.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../shoplayout.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  Icon favoriteIcon = Icon(
    Icons.favorite,
    color: Colors.purple.shade200,
  );
  Icon unFavoriteIcon = const Icon(Icons.favorite_border_rounded);

  Map<dynamic, dynamic> favorites = {};
  Map<dynamic, dynamic> cart = {};
  Map<int, dynamic> discount = {};
  HomeProductModel? homeProductModel;
  HomeProductModel? discountProductModel;

  void getDiscountData() {
    emit(ShopDiscountState());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      if (discount != 0) {
        discountProductModel = HomeProductModel.fromJson(value.data);
      }
      if (kDebugMode) {
        print('Discount ' + discountProductModel!.discount);
      }
      discountProductModel!.discount?.products.forEach((element) {
        discount.addAll({element.id: element.discount});
      });
      emit(ShopDicountOkState());
    }).catchError((error) {
      emit(ShopDicountErrorState(error));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: Home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      var i = 0;
      if (kDebugMode) {
        print('Home ' + homeModel!.status.toString());
      }
      for (var element in homeModel!.data.products) {
        productsMap[element.id] = i++;
        favorites.addAll({element.id: element.inFavorites});
      }
      for (var element in homeModel!.data.products) {
        cart.addAll({element.id: element.inCart});
      }
      getDiscountData();
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      emit(ShopErrorHomeState(error));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  ProductDetailsModel? productDetailsModel;

  void getProductData(int? productId) {
    emit(ProductLoadingState());
    DioHelper.getData(url: 'products/$productId', token: token).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      if (kDebugMode) {
        print('Product Detail ' + productDetailsModel!.status.toString());
      }
      emit(ProductSuccessState());
    }).catchError((error) {
      emit(ProductErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoryData() {
    emit(ShopLoadingCategoryState());
    DioHelper.getData(
      url: Get_categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      if (kDebugMode) {
        print('Categories ' + categoriesModel!.status.toString());
      }
      emit(ShopSuccessCategoryState());
    }).catchError((error) {
      emit(ShopErrorCategoryState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  CategoryDetailModel? categoriesDetailModel;

  void getCategoriesDetailData(int? categoryID) {
    emit(CategoryDetailsLoadingState());
    DioHelper.getData(url: CATEGORIES_DETAIL, query: {
      'category_id': '$categoryID',
    }).then((value) {
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      if (kDebugMode) {
        print('categories Detail ' + categoriesDetailModel!.status.toString());
      }
      emit(CategoryDetailsSuccessState());
    }).catchError((error) {
      emit(CategoryDetailsErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  FavoriteModel? favoritesModel;

  void getFavoriteData() {
    emit(ShopLoadingChangeFavState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoriteModel.fromJson(value.data);
      if (kDebugMode) {
        print('Favorites ' + favoritesModel!.status.toString());
      }
      emit(ShopSuccessGetFavState());
    }).catchError((error) {
      emit(ShopErrorGetFavState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  AddOrderModel? addOrderModel;
  int addressId = 0;

  void addNewOrder({int? addressId, context}) {
    emit(AddOrderLoadingState());
    DioHelper.postData(
        url: Orders,
        data: {
          'address_id': addressId,
          "payment_method": 1,
          "use_points": false,
        },
        token: token)
        .then((value) {
      addOrderModel = AddOrderModel.fromJson(value.data);
      if (addOrderModel!.status) {
        getCartData();
        getOrders();
        emit(AddOrderSuccessState(addOrderModel!));
      } else {
        getCartData();
        getOrders();
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AddOrderErrorState(error));
    });
  }

  ShopLoginModel? userModel;

  void getProfileData() {
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      if (kDebugMode) {
        print('Profile ' + userModel!.status.toString());
      }
      if (kDebugMode) {
        print(userModel!.data!.token);
      }
      emit(ProfileSuccessState());
    }).catchError((error) {
      emit(ProfileErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void updateProfileData({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      if (kDebugMode) {
        print('Update Profile ' + userModel!.status.toString());
      }
      emit(UpdateProfileSuccessState(userModel!));
    }).catchError((error) {
      emit(UpdateProfileErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  ShopLoginModel? passwordModel;

  void changePassword({required context,
    required String currentPass,
    required String newPass}) {
    emit(ChangePassLoadingState());
    DioHelper.postData(url: 'change-password', token: token, data: {
      'current_password': currentPass,
      'new_password': newPass,
    }).then((value) {
      passwordModel = ShopLoginModel.fromJson(value.data);
      if (kDebugMode) {
        print('Change Password ' + passwordModel!.status.toString());
      }
      if (passwordModel!.status) {
        showToast(text: passwordModel!.message!, state: ToastStates.SUCCESS);
      } else {
        showToast(text: passwordModel!.message!, state: ToastStates.ERROR);
      }
      emit(ChangePassSuccessState(userModel!));
    }).catchError((error) {
      emit(ChangePassErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  ChangeToFavoritesModel? changeToFavoritesModel;

  void changeToFavorite(int? productID) {
    favorites[productID] = !favorites[productID];
    emit(ChangeFavoritesManuallySuccessState());

    emit(ShopLoadingChangeFavState());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {'product_id': productID}).then((value) {
      changeToFavoritesModel = ChangeToFavoritesModel.fromJson(value.data);
      if (kDebugMode) {
        print(changeToFavoritesModel!.status);
      }
      if (changeToFavoritesModel!.status == false) {
        favorites[productID] = !favorites[productID]!;
      } else {
        getFavoriteData();
      }
      emit(ChangeFavoritesErrorState());
    }).catchError((error) {
      favorites[productID] = !favorites[productID];
      emit(ShopErrorChangeFavState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  /// CART API
  late AddCartModel addCartModel;

  void addToCart(int? productId) {
    emit(AddCartLoadingState());

    var productQuantity = productsQuantity[productId];
    bool added = productQuantity == null;
    if (added) {
      productsQuantity[productId] = 1;
    } else {
      cartItemsIds.remove(productCartIds[productId]);
      productsQuantity.remove(productId);
      productsQuantity[productId] = 0;
      productCartIds.remove(productId);
    }
    DioHelper.postData(
        url: Carts,
        token: token,
        data: {'product_id': productId}).then((value) {
      addCartModel = AddCartModel.fromJson(value.data);
      if (kDebugMode) {
        print('AddCart ' + addCartModel.status.toString());
      }
      if (addCartModel.status) {
        getCartData();
        getHomeData();
      } else {
        showToast(text: addCartModel.message!, state: ToastStates.SUCCESS);
      }
      emit(AddCartSuccessState(addCartModel));
    }).catchError((error) {
      emit(AddCartErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  AddCartModel? cartItem;

  void changeCartItem(int productId) {
    emit(ShopChangeCartItemState());
    var productQuantity = productsQuantity[productId];
    bool added = productQuantity == null;
    if (added) {
      productsQuantity[productId] = 0;
    } else {
      cartItemsIds.remove(productCartIds[productId]);
      productsQuantity.remove(productId);
      productCartIds.remove(productId);
    }
    DioHelper.postData(
      url: Carts,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      cartItem = AddCartModel.fromJson(value.data);
      emit(ShopSuccessChangeCartItemState(cartItem!));
      getCartData();
    }).catchError((error) {
      emit(ShopErrorChangeCartItemState());
      if (kDebugMode) {
        print("Error Change Cart Data $error");
      }
    });
  }

  late UpdateCartModel updateCartModel;

  void updateCartData(int? cartId, int? quantity) {
    emit(UpdateCartLoadingState());

    DioHelper.putData(
      url: 'carts/$cartId',
      data: {
        'quantity': '$quantity',
      },
      token: token,
    ).then((value) {
      updateCartModel = UpdateCartModel.fromJson(value.data);
      if (updateCartModel.status) {
        getCartData();
      } else {
        showToast(text: updateCartModel.message!, state: ToastStates.SUCCESS);
      }
      if (kDebugMode) {
        print('Update Cart ' + updateCartModel.status.toString());
      }
      emit(UpdateCartSuccessState());
    }).catchError((error) {
      emit(UpdateCartErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  CartModel? cartModel;

  void getCartData() {
    emit(CartLoadingState());
    DioHelper.getData(
      url: Carts,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(CartSuccessState());
      if (kDebugMode) {
        print('Get Cart ' + cartModel!.status.toString());
      }
    }).catchError((error) {
      emit(CartErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  /// END OF CART API

  /// Address API
  bool deleteAddresses = false;
  ChangeAddressModel? changeAddressModel;

  void addAddress({
    required name,
    required city,
    required region,
    required details,
    String? notes,
  }) {
    deleteAddresses = false;
    emit(AddAddressLoadingState());
    DioHelper.postData(
        url: Address,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          "latitude": 30.0616863,
          "longitude": 31.3260088,
          "notes": notes,
        },
        token: token)
        .then((value) {
      changeAddressModel = ChangeAddressModel.fromJson(value.data);
      getAddresses();
      emit(AddAddressSuccessState(changeAddressModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AddAddressErrorState());
    });
  }

  bool isNewAddress = false;

  GetAddressModel? addressModel;

  void getAddresses() {
    emit(AddressesLoadingState());
    DioHelper.getData(url: Address, token: token).then((value) {
      addressModel = GetAddressModel.fromJson(value.data);
      if (kDebugMode) {
        print('Get Addresses ' + addressModel!.status.toString());
      }
      emit(AddressesSuccessState(addressModel!));
    }).catchError((error) {
      emit(AddressesErrorState());
      if (kDebugMode) {
        print('Get Addresses Error ${error.toString()}');
      }
    });
  }

  void updateAddress({
    required name,
    required city,
    required region,
    required details,
    String? notes,
  }) {
    deleteAddresses = false;
    emit(UpdateAddressLoadingState());
    DioHelper.putData(
        url: "addresses/$addressId",
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          "latitude": 30.0616863,
          "longitude": 31.3260088,
          "notes": notes
        },
        token: token)
        .then((value) {
      changeAddressModel = ChangeAddressModel.fromJson(value.data);
      getAddresses();
      emit(UpdateAddressSuccessState(changeAddressModel!));
    }).catchError((error) {
      if (kDebugMode) {
        print("Change User Address Error : ${error.toString()}");
      }
      emit(UpdateAddressErrorState());
    });
  }

  void deleteAddress({required addressId}) {
    emit(DeleteAddressLoadingState());
    DioHelper.deleteData(url: "addresses/$addressId", token: token)
        .then((value) {
      changeAddressModel = ChangeAddressModel.fromJson(value.data);
      deleteAddresses = true;
      emit(DeleteAddressSuccessState(changeAddressModel!));
      getAddresses();
    }).catchError((error) {
      if (kDebugMode) {
        print("Change User Address Error : ${error.toString()}");
      }
      emit(DeleteAddressErrorState());
    });
  }

  /// END OF ADDRESS API

  late FAQsModel faqsModel;

  void getFAQsData() {
    emit(FAQsLoadingState());
    DioHelper.getData(
      url: 'faqs',
    ).then((value) {
      faqsModel = FAQsModel.fromJson(value.data);
      if (kDebugMode) {
        print('Get FAQs ' + faqsModel.status.toString());
      }
      emit(FAQsSuccessState());
    }).catchError((error) {
      emit(FAQsErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  int currentIndex = 0;

  changeBottomNav(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  List<Widget> screens = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
  ];

  List<Widget> bottomItems = [
    const Icon(Icons.home),
    const Icon(Icons.apps_rounded),
    const Icon(Icons.favorite),
  ];

  void getToken() {
    token = CacheHelper.getData(key: 'token');
    emit(GetTokenSuccessState());
  }

  bool inCart = false;

  Widget topSheet(model, context) {
    if (inCart) {
      return MaterialBanner(
          padding: EdgeInsets.zero,
          leading: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 30,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model!.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Added to Cart',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              )
            ],
          ),
          actions: [
            OutlinedButton(
                onPressed: () {
                  inCart = false;
                  emit(CloseTopSheet());
                },
                child: const Text('CONTINUE SHOPPING')),
            ElevatedButton(
              onPressed: () {
                navigateTo(context, ShopLayoutScreen());
                ShopCubit.get(context).currentIndex = 3;
              },
              child: const Text('CHECKOUT'),
            ),
          ]);
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  bool showCurrentPassword = false;
  IconData currentPasswordIcon = Icons.visibility;

  void changeCurrentPassIcon(context) {
    showCurrentPassword = !showCurrentPassword;
    if (showCurrentPassword)
      currentPasswordIcon = Icons.visibility_off;
    else
      currentPasswordIcon = Icons.visibility;
    emit(ChangeSuffixIconState());
  }

  bool showNewPassword = false;
  IconData newPasswordIcon = Icons.visibility;

  void changeNewPassIcon(context) {
    showNewPassword = !showNewPassword;
    if (showNewPassword)
      newPasswordIcon = Icons.visibility_off;
    else
      newPasswordIcon = Icons.visibility;
    emit(ChangeSuffixIconState());
  }

  Map<int, int> productCartIds = {};
  var productsQuantity = {};
  Set cartItemsIds = {};
  var totalCarts = 0;

  void getQuantities() {
    totalCarts = 0;
    if (productsQuantity.isNotEmpty) {
      productsQuantity.forEach((key, value) {
        totalCarts += (value as int);
      });
    }
  }

  var productsMap = {};

  GetOrderModel? orderModel;

  void getOrders() {
    emit(GetOrdersLoadingState());
    DioHelper.getData(url: Orders, token: token).then((orders) {
      orderModel = GetOrderModel.fromJson(orders.data);
      ordersDetails.clear();
      ordersIds.clear();
      for (var element in orderModel!.data.data) {
        ordersIds.add(element.id);
      }
      emit(GetOrdersSuccessState(orderModel!));
      getOrdersDetails();
    }).catchError((error) {
      emit(GetOrdersErrorState(error));
      if (kDebugMode) {
        print('Get Orders Error ${error.toString()}');
      }
    });
  }

  List<int> ordersIds = [];
  OrderDetailsModel? orderItemDetails;
  List<OrderDetailsModel> ordersDetails = [];

  void getOrdersDetails() async {
    emit(OrderDetailsLoadingState());
    if (ordersIds.isNotEmpty) {
      for (var id in ordersIds) {
        await DioHelper.getData(url: "$Orders/$id", token: token)
            .then((orderDetails) {
          orderItemDetails = OrderDetailsModel.fromJson(orderDetails.data);
          ordersDetails.add(orderItemDetails!);
          emit(OrderDetailsSuccessState(orderItemDetails!));
        }).catchError((error) {
          emit(OrderDetailsErrorState(error));
          if (kDebugMode) {
            print('Get Orders Details Error ${error.toString()}');
          }
          return;
        });
      }
    }
  }

  CancelOrderModel? cancelOrderModel;

  void cancelOrder({required int id}) {
    emit(CancelOrderLoadingState());
    DioHelper.getData(url: "orders/$id/cancel", token: token).then((value) {
      cancelOrderModel = CancelOrderModel.fromJson(value.data);
      getOrders();
      emit(CancelOrderSuccessState(cancelOrderModel!));
    }).catchError((error) {
      print('${error.toString()}');
      emit(CancelOrderErrorState(error));
    });
  }
}
