import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';

class ShopSearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  ShopCubit shopCubit;

  ShopSearchScreen(this.shopCubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      defaultFormField(
                        context: context,
                        controller: searchController,
                        type: TextInputType.text,
                        keyboardType: TextInputType.text,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "enter text to search";
                          }
                        },
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        onChange: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        labelText: 'Search',
                        prefix: Icons.search,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context).model.data!.data[index],
                              context,
                              isOldPrice: false,
                            ),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: SearchCubit.get(context)
                                .model
                                .data!
                                .data
                                .length,
                          ),
                        ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
