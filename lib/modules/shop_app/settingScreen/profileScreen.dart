import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../shop_login/cubit/statues.dart';
import 'changePasswordScreen.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) if (state
            .updateUserModel.status)
          showToast(
              text: state.updateUserModel.message!, state: ToastStates.SUCCESS);
        else
          showToast(
              text: state.updateUserModel.message!, state: ToastStates.ERROR);
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        phoneController.text = model.data!.phone!;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                Text('Shop App'),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome ${cubit.userModel!.data!.name!.split(' ').elementAt(0)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${cubit.userModel!.data!.email}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 280,
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state is UpdateProfileLoadingState)
                            Column(
                              children: [
                                LinearProgressIndicator(),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Text(
                                'PERSONAL INFORMATION',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              TextButton(
                                  onPressed: () {
                                    editPressed(
                                        context: context,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: cubit.userModel!.data!.email);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '$editText',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Name',
                            style: TextStyle(fontSize: 15),
                          ),
                          defaultFormField(
                            context: context,
                            controller: nameController,
                            prefix: Icons.person,
                            enabled: isEdit ? true : false,
                            validate: (value) {},
                            type: TextInputType.name,
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Phone',
                            style: TextStyle(fontSize: 15),
                          ),
                          defaultFormField(
                            context: context,
                            controller: phoneController,
                            prefix: Icons.phone,
                            enabled: isEdit ? true : false,
                            validate: (value) {},
                            type: TextInputType.phone,
                            keyboardType: TextInputType.phone,
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SECURITY INFORMATION',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              navigateTo(context, ChangePasswordScreen());
                            },
                            child: Text('Change Password')),
                      ],
                    ),
                  ),
                  SizedBox(height: 200)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
