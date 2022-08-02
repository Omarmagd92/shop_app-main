import 'package:ShopApp/modules/shop_app/shop_register/cubit/statue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/shop_model/shop_model.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStatues> {
  ShopRegisterCubit() : super(ShopRegisterInitialStatue());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(ShopRegisterLoadingStatue());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      //  print(loginModel.status);
      // print(loginModel.message);
      // print(loginModel.data?.token);
      emit(ShopRegisterSuccessStatue(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorStatue(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopAddPasswordStatue());
  }
}
