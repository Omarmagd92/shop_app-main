import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../models/shop_model/cartModels/cartModel.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../product_details/productDeatils.dart';
import '../search/shop_searchScreen.dart';
import '../settingScreen/addressesScreen.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  TextEditingController counterController = TextEditingController();

  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CartModel cartModel = ShopCubit.get(context).cartModel!;
        cartLength = ShopCubit.get(context).cartModel!.data.cartItems.length;
        return ShopCubit.get(context).cartModel!.data.cartItems.isEmpty
            ? Center(
                child: Scaffold(
                  appBar: AppBar(
                    titleSpacing: 0,
                    title: Row(
                      children: const [
                        Text('Shop App'),
                      ],
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            navigateTo(context,
                                ShopSearchScreen(ShopCubit.get(context)));
                          },
                          icon: const Icon(Icons.search)),
                    ],
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 70,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Your Cart is empty',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            'Be Sure to fill your cart with something you like',
                            style: TextStyle(fontSize: 15))
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: const [
                      Text('Shop App'),
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          navigateTo(context,
                              ShopSearchScreen(ShopCubit.get(context)));
                        },
                        icon: const Icon(Icons.search)),
                  ],
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: Column(
                      children: [
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => cartProducts(
                                ShopCubit.get(context)
                                    .cartModel!
                                    .data
                                    .cartItems[index],
                                context),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: cartLength),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Subtotal' + '($cartLength Items)',
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  const Spacer(),
                                  Text('EGP ' + '${cartModel.data.subTotal}',
                                      style:
                                          const TextStyle(color: Colors.grey))
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: const [
                                  Text('Shipping Fee'),
                                  Spacer(),
                                  Text(
                                    'Free',
                                    style: TextStyle(color: Colors.green),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  const Text('TOTAL',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const Text(
                                    ' Inclusive of VAT',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const Spacer(),
                                  Text('EGP ' + '${cartModel.data.total}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (ShopCubit.get(context).totalCarts >= 0)
                          Align(
                            alignment: const Alignment(0, 1),
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                              child: ConditionalBuilder(
                                condition:
                                    ShopCubit.get(context).addressId != 0,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: state is! AddOrderLoadingState
                                      ? primaryButton(
                                          text:
                                              "Checkout ( ${NumberFormat.currency(decimalDigits: 0, symbol: "").format(ShopCubit.get(context).cartModel!.data.total)} LE )",
                                          onPressed: () {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.QUESTION,
                                              animType: AnimType.SCALE,
                                              title:
                                                  'Are you Sure for Confirm this Order ?',
                                              btnOkOnPress: () {
                                                ShopCubit.get(context)
                                                    .addNewOrder();
                                              },
                                              btnCancelText: "Cancel",
                                              btnCancelOnPress: () {},
                                            ).show();
                                          },
                                        )
                                      : const CircularProgressIndicator(),
                                ),
                                fallback: (context) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: primaryButton(
                                    text:
                                        'Add your address to continue checkout.',
                                    onPressed: () {
                                      navigateTo(context, AddressesScreen());
                                    },
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        // primaryButton(
                        //   text:
                        //   "Checkout ( ${NumberFormat.currency(decimalDigits: 0, symbol: "").format(ShopCubit.get(context).cartModel!.data.total)} LE )",
                        //   onPressed: () {
                        //     AwesomeDialog(
                        //       context: context,
                        //       dialogType: DialogType.QUESTION,
                        //       animType: AnimType.SCALE,
                        //       title:
                        //       'Are you Sure for Confirm this Order ?',
                        //       btnOkOnPress: () {
                        //
                        //        ShopCubit.get(context).addNewOrder();
                        //       },
                        //       btnCancelText: "Cancel",
                        //       btnCancelOnPress: () {},
                        //     )..show();
                        //   },
                        // )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget cartProducts(CartItems? model, context) {
    counterController.text = '${model!.quantity}';
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductData(model.product.id);
        navigateTo(context, ProductDetails());
      },
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  Image(
                    image: NetworkImage(model.product.image),
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.product.name,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          'EGP ' + '${model.product.price}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        if (model.product.discount != 0)
                          Text(
                            'EGP' + '${model.product.oldPrice}',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: MaterialButton(
                    onPressed: () {
                      int quantity = model.quantity! - 1;
                      if (quantity != 0) {
                        ShopCubit.get(context)
                            .updateCartData(model.id, quantity);
                      }
                    },
                    child: const Icon(
                      Icons.remove,
                      size: 17,
                      color: Colors.deepOrange,
                    ),
                    minWidth: 20,
                    //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${model.quantity}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: MaterialButton(
                    onPressed: () {
                      int quantity = model.quantity! + 1;
                      if (quantity <= 5) {
                        ShopCubit.get(context)
                            .updateCartData(model.id, quantity);
                      }
                    },
                    child: Icon(
                      Icons.add,
                      size: 17,
                      color: Colors.green[500],
                    ),
                    minWidth: 10,
                    //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.zero,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    ShopCubit.get(context).addToCart(model.product.id);
                    ShopCubit.get(context).changeToFavorite(model.product.id);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.grey,
                        size: 18,
                      ),
                      SizedBox(
                        width: 2.5,
                      ),
                      Text(
                        'Move to Wishlist',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey[300],
                ),
                TextButton(
                    onPressed: () {
                      ShopCubit.get(context).addToCart(model.product.id);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.grey,
                          size: 18,
                        ),
                        SizedBox(
                          width: 2.5,
                        ),
                        Text('Remove',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            )),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
