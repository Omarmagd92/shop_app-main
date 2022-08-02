import 'package:ShopApp/modules/shop_app/shop_login/cubit/statues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/shop_model/shop_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStatues> {
  ShopLoginCubit() : super(ShopLoginInitialStatue());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingStatue());

    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      token = CacheHelper.getData(key: 'token');
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      //  print(loginModel.status);
      print(loginModel!.message);
      // print(loginModel.data?.token);
      emit(ShopLoginSuccessStatue(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorStatue(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordStatue());
  }
}
