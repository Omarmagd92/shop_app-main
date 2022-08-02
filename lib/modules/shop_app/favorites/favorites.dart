import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          favLength = ShopCubit.get(context).favoritesModel!.data!.data.length;
          return ShopCubit.get(context).favoritesModel!.data!.data.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 70,
                        color: Colors.purple.shade200,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Your favorite list is empty',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                          'Be Sure to fill your favorites with something you like',
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildListProduct(
                              ShopCubit.get(context)
                                  .favoritesModel!
                                  .data!
                                  .data[index]
                                  .product,
                              context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: favLength),
                    ],
                  ),
                );
        });
  }
}
