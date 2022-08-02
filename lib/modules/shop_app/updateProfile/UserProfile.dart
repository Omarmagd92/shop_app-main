import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../shared/components/components.dart';

// ignore: must_be_immutable
class UserProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessUserDataState) {
          if (state.loginModel.status) {
            showToast(
                text: state.loginModel.message!,
                state: ToastStates.SUCCESS,
                seconds: 3);
          } else {
            showToast(
              text: state.loginModel.message!,
              state: ToastStates.ERROR,
              seconds: 3,
            );
          }
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Profile',
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (state is ShopLoadingUpdateUserDataState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        context: context,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'name must not be Empty !!';
                          }
                        },
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        prefix: Icons.person,
                        labelText: "Name",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        context: context,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Email must not be Empty !!';
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefix: Icons.email_outlined,
                        labelText: "Email address",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        context: context,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Phone must not be Empty !!';
                          }
                        },
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        prefix: Icons.phone,
                        labelText: "Phone",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoadingUpdateUserDataState,
                        builder: (context) => Center(
                          child: defaultTextButton(
                            text: "Update",
                            style: TextStyle(color: Colors.purple.shade400),
                            isUpperCase: true,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).updateProfileData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
