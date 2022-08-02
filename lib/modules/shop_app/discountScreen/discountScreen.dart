import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/statue.dart';
import '../../../models/shop_model/home_model.dart';
import '../../../shared/components/components.dart';
import '../product_details/productDeatils.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessChangeFavState) {
        if (state.model.status) {
          showToast(text: state.model.message!, state: ToastStates.ERROR);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: const [
              Text(
                'Hot offers',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).discount.isNotEmpty,
          builder: (context) => productsBuilder(
              ShopCubit.get(context).homeProductModel!, context),
          fallback: (context) => const Center(
              child: Text(
            "No offers come back soon",
            style: TextStyle(
              fontSize: 25,
            ),
          )),
        ),
      );
    });
  }

  Widget productsBuilder(HomeProductModel model, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.58,
              children: List.generate(
                (model.discount > 0),
                (index) => buildGridProducts(model.discount[index], context),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      );

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
                        ? Colors.purple.shade800
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
}
