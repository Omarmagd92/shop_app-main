import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:intl/intl.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../models/shop_model/catogery_model.dart';
import '../../../models/shop_model/home_model.dart';
import '../../../shared/components/components.dart';
import '../catogries/categoryProductsScreen.dart';
import '../product_details/productDeatils.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessChangeFavState) {
        if (state.model.status) {
          showToast(text: state.model.message!, state: ToastStates.ERROR);
        }
      }
    }, builder: (context, state) {
      return ConditionalBuilder(
        condition: ShopCubit.get(context).homeModel != null &&
            ShopCubit.get(context).categoriesModel != null,
        builder: (context) => productsBuilder(ShopCubit.get(context).homeModel!,
            ShopCubit.get(context).categoriesModel!, context),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      );
    });
  }

  Widget productsBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: Scrollbar(
                      thickness: 1,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => categoriesAvatar(
                            categoriesModel.data.data[index], context),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                        itemCount: categoriesModel.data.data.length,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "New Products",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.58,
              children: List.generate(
                (model.data.products.length),
                (index) =>
                    buildGridProducts(model.data.products[index], context),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      );

  Widget productItemBuilder(HomeProductModel model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getProductData(model.id);
        navigateTo(context, ProductDetails());
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsetsDirectional.only(start: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage('${model.image}'),
                height: 150,
                width: 150,
              ),
              if (model.discount != 0)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Discount',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                )
            ]),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${model.name}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'EGP',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (model.discount != 0)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'EGP',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          '${model.discount}' + '% OFF',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 11),
                        )
                      ],
                    ),
                ]),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changeToFavorite(model.id);
                    print(model.id);
                  },
                  icon: Conditional.single(
                    context: context,
                    conditionBuilder: (context) =>
                        ShopCubit.get(context).favorites[model.id],
                    widgetBuilder: (context) =>
                        ShopCubit.get(context).favoriteIcon,
                    fallbackBuilder: (context) =>
                        ShopCubit.get(context).unFavoriteIcon,
                  ),
                  padding: const EdgeInsets.all(0),
                  iconSize: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget positionedFill(text) => Positioned.fill(
        child: Align(
          alignment: const Alignment(1, -1),
          child: ClipRect(
            child: Banner(
              message: "Sale",
              textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
              location: BannerLocation.topEnd,
              color: Colors.red,
              child: Container(
                height: 100,
              ),
            ),
          ),
        ),
      );

  Widget buildGridProducts(HomeProductModel model, context) => Card(
        elevation: 4,
        margin: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: const Alignment(-1, -1),
              children: [
                InkWell(
                  onTap: () {
                    ShopCubit.get(context).getProductData(model.id);
                    navigateTo(context, ProductDetails());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Image(
                        image: NetworkImage(model.image!),
                        // fit: BoxFit.cover,
                        height: 180,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundColor: ShopCubit.get(context).favorites[model.id]!
                        ? Colors.purple.shade200
                        : Colors.grey,
                    child: const Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    ShopCubit.get(context).changeToFavorite(model.id);
                    print(model.id);
                  },
                ),
                if (model.discount > 0) positionedFill(model.discount),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (model.discount != 0)
                    Row(
                      children: [
                        Text(
                          'Save ${NumberFormat.currency(decimalDigits: 0, symbol: "").format(model.oldPrice - model.price)} (${model.discount}%)',
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        NumberFormat.currency(decimalDigits: 0, symbol: "")
                            .format(model.price),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const Text(
                        ' LE  ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (model.discount > 0)
                    Text(
                      ' ${NumberFormat.currency(decimalDigits: 0, symbol: "").format(model.oldPrice)} LE',
                      style: const TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget categoriesAvatar(DataModel model, context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).getCategoriesDetailData(model.id);
        navigateTo(context, CategoryProductsScreen(model.name));
      },
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple.shade200,
                radius: 36,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
                child: Image(
                  image: NetworkImage('${model.image}'),
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text('${model.name}'),
        ],
      ),
    );
  }
}
