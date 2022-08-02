import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../models/shop_model/productDetialsModel.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../cartScreen/cartScreen.dart';
import '../search/shop_searchScreen.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  PageController productImages = PageController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ProductDetailsData? model =
            ShopCubit.get(context).productDetailsModel?.data;
        return Scaffold(
          key: scaffoldKey,
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
                    navigateTo(
                        context, ShopSearchScreen(ShopCubit.get(context)));
                  },
                  icon: const Icon(Icons.search)),
            ],
          ),
          body: state is ProductLoadingState
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple.shade200,
                  ),
                )
              : Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '${model!.name}',
                                  style: const TextStyle(fontSize: 20),
                                )),
                            SizedBox(
                              height: 400,
                              width: double.infinity,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  PageView.builder(
                                    controller: productImages,
                                    itemBuilder: (context, index) => Image(
                                      image: NetworkImage(model.images![index]),
                                    ),
                                    itemCount: model.images!.length,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ShopCubit.get(context)
                                          .changeToFavorite(model.id);
                                      if (kDebugMode) {
                                        print(model.id);
                                      }
                                    },
                                    icon: Conditional.single(
                                      context: context,
                                      conditionBuilder: (context) =>
                                          ShopCubit.get(context)
                                              .favorites[model.id],
                                      widgetBuilder: (context) =>
                                          ShopCubit.get(context).favoriteIcon,
                                      fallbackBuilder: (context) =>
                                          ShopCubit.get(context).unFavoriteIcon,
                                    ),
                                    iconSize: 35,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SmoothPageIndicator(
                              controller: productImages,
                              count: model.images!.length,
                              effect: ExpandingDotsEffect(
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.purple.shade200,
                                  expansionFactor: 4,
                                  dotHeight: 7,
                                  dotWidth: 10,
                                  spacing: 10),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EGP'
                                          '' +
                                      '${model.price}',
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                if (model.discount != 0)
                                  Row(
                                    children: [
                                      Text(
                                        'EGP' + '${model.oldPrice}',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${model.discount}% OFF',
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 15,
                                ),
                                myDivider(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'FREE delivery by ',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('${getDateTomorrow()}'),
                                    Text('${getDateTomorrow()}'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Order in 19h 16m',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                myDivider(),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text('Offer Details',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.check_circle_outline,
                                        color: Colors.green),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                        'Enjoy free returns with this offer'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                myDivider(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.check_circle_outline,
                                        color: Colors.green),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text('1 Year warranty'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                myDivider(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text('Sold by ShopMart'),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                myDivider(),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text('Overview',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text('${model.description}'),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                              width: double.infinity,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.purple.shade200),
                          ),
                          onPressed: () {
                            if (ShopCubit.get(context).cart[model.id]) {
                              showToast(
                                  text:
                                      ('Already in Your Cart \nCheck your cart To Edit or Delete '),
                                  state: ToastStates.ERROR);
                            } else {
                              ShopCubit.get(context).addToCart(model.id);
                              scaffoldKey.currentState!.showBottomSheet(
                                (context) => Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${model.name}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text(
                                                  'Added to Cart',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'CONTINUE SHOPPING',
                                                style: TextStyle(
                                                    color:
                                                        Colors.purple.shade200),
                                              ),
                                              // style: ButtonStyle(
                                              //     side: MaterialStateProperty.all(BorderSide(
                                              //         color: Colors.purple.shade200,
                                              //         width: 1.0,
                                              //         style: BorderStyle.solid))),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  navigateTo(
                                                      context, CartScreen());
                                                },
                                                child: const Text('CHECKOUT')),
                                          ]),
                                    ],
                                  ),
                                ),
                                elevation: 50,
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_cart_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Add to Cart',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
